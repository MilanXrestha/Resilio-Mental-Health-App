import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constants/api_endpoints.dart';
import '../../../../../core/errors/failures.dart';
import '../../../audio/data/datasources/audio_remote_datasource.dart';
import '../../../audio/domain/entities/audio_entity.dart';
import '../../../categories/data/datasources/remote/category_remote_data_source.dart';
import '../../../dashboard/data/datasources/remote/quote_remote_data_source.dart';
import '../../../dashboard/domain/entities/quote_entity.dart';
import '../../../images/data/datasources/remote/image_remote_data_source.dart';
import '../../../tips/data/datasources/remote/tip_remote_data_source.dart';
import '../../../video/data/datasources/remote/video_remote_data_source.dart';
import '../../domain/entities/explore_item_entity.dart';
import '../../domain/repositories/explore_repository.dart';
import '../datasources/explore_local_data_source.dart';

@LazySingleton(as: ExploreRepository)
class ExploreRepositoryImpl implements ExploreRepository {
  final Dio _dio;
  final AudioRemoteDataSource _audioDataSource;
  final VideoRemoteDataSource _videoDataSource;
  final QuoteRemoteDataSource _quoteDataSource;
  final TipRemoteDataSource _tipDataSource;
  final ImageRemoteDataSource _imageDataSource;
  final CategoryRemoteDataSource _categoryDataSource;
  final ExploreLocalDataSource _localDataSource;

  ExploreRepositoryImpl(
      this._dio,
      this._audioDataSource,
      this._videoDataSource,
      this._quoteDataSource,
      this._tipDataSource,
      this._imageDataSource,
      this._categoryDataSource,
      this._localDataSource,
      );

  @override
  Future<Either<Failure, List<ExploreItemEntity>>> getAllExploreItems() async {
    try {
      final categories = await _categoryDataSource.getCategories();
      final allItemsMap = <String, ExploreItemEntity>{};

      // Fetch all content from the reliable JSON /categories/{id}/content endpoint
      // per category. Individual content endpoints (audio, tips, etc.) return
      // stripped data and are not used here.
      await Future.wait(
        categories.map((category) async {
          try {
            final result = await getExploreItemsByCategory(category.id);
            result.fold(
              (_) {},
              (items) {
                for (final item in items) {
                  if (item.type == ExploreItemType.category) return;
                  // Guarantee the item is linked to this category even if the
                  // server omits the categoryId field on individual items.
                  final enriched = item.categoryIds.isEmpty
                      ? item.copyWith(categoryIds: [category.id])
                      : item;
                  allItemsMap.putIfAbsent(enriched.id, () => enriched);
                }
              },
            );
          } catch (_) {}
        }),
      );

      // Add category items so the explore screen can render section headers.
      for (final category in categories) {
        allItemsMap.putIfAbsent(
          category.id,
          () => ExploreItemEntity(
            id: category.id,
            title: category.name,
            description: category.description,
            imageUrl: category.imageUrl,
            type: ExploreItemType.category,
            tags: const [],
            categoryIds: [category.id],
            createdAt: category.createdAt,
          ),
        );
      }

      final allItems = allItemsMap.values.toList();
      allItems.sort((a, b) {
        if (a.isFeatured != b.isFeatured) return a.isFeatured ? -1 : 1;
        return b.createdAt.compareTo(a.createdAt);
      });

      return Right(allItems);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch explore items: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ExploreItemEntity>>> getExploreItemsByType(
      ExploreItemType type, {
        int limit = 20,
        int offset = 0,
      }) async {
    try {
      List<ExploreItemEntity> items;

      switch (type) {
        case ExploreItemType.audio:
          items = await _fetchAudioItems();
          break;
        case ExploreItemType.shortVideo:
        case ExploreItemType.longVideo:
          items = await _fetchVideoItems();
          items = items.where((i) => i.type == type).toList();
          break;
        case ExploreItemType.quote:
          items = await _fetchQuoteItems();
          break;
        case ExploreItemType.tip:
          items = await _fetchTipItems();
          break;
        case ExploreItemType.image:
          items = await _fetchImageItems();
          break;
        case ExploreItemType.category:
          items = await _fetchCategoryItems();
          break;
      }

      // Apply pagination
      final paginatedItems = items.skip(offset).take(limit).toList();

      return Right(paginatedItems);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch items: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ExploreItemEntity>>> getExploreItemsByCategory(
      String categoryId) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.categoryContent}/$categoryId/content',
        options: Options(responseType: ResponseType.json),
      );

      if (response.statusCode != 200 || response.data == null) {
        return Left(ServerFailure('Failed to fetch category content'));
      }

      final data = response.data as Map<String, dynamic>;
      final allItems = <ExploreItemEntity>[];

      // Audio
      final audioList = (data['audio'] as List?) ?? [];
      for (final a in audioList) {
        allItems.add(ExploreItemEntity(
          id: a['id'] ?? '',
          title: a['title'] ?? '',
          subtitle: a['artistName'] ?? '',
          description: a['description'],
          imageUrl: a['coverImageUrl'],
          thumbnailUrl: a['thumbnailUrl'],
          type: ExploreItemType.audio,
          tags: List<String>.from(a['moodTags'] ?? []),
          categoryIds: (a['categoryId'] as String?)?.isNotEmpty == true
              ? [a['categoryId']]
              : [],
          isFeatured: a['isFeatured'] ?? false,
          isPremium: a['isPremium'] ?? false,
          durationSeconds: a['durationSeconds'] as int?,
          createdAt: _parseDate(a['createdAt']),
          metadata: {'audioUrl': a['audioUrl'] ?? ''},
        ));
      }

      // Short videos
      final shortList = (data['shortVideos'] as List?) ?? [];
      for (final v in shortList) {
        allItems.add(_videoToEntity(v, ExploreItemType.shortVideo));
      }

      // Long videos
      final longList = (data['longVideos'] as List?) ?? [];
      for (final v in longList) {
        allItems.add(_videoToEntity(v, ExploreItemType.longVideo));
      }

      // Quotes
      final quoteList = (data['quotes'] as List?) ?? [];
      for (final q in quoteList) {
        allItems.add(ExploreItemEntity(
          id: q['id'] ?? '',
          title: q['quoteText'] ?? '',
          subtitle: q['author'],
          imageUrl: q['authorIconUrl'],
          type: ExploreItemType.quote,
          tags: const [],
          categoryIds: (q['categoryId'] as String?)?.isNotEmpty == true
              ? [q['categoryId']]
              : [],
          isFeatured: q['isFeatured'] ?? false,
          isPremium: q['isPremium'] ?? false,
          createdAt: _parseDate(q['createdAt']),
        ));
      }

      // Tips
      final tipList = (data['tips'] as List?) ?? [];
      for (final t in tipList) {
        allItems.add(ExploreItemEntity(
          id: t['id'] ?? '',
          title: t['title'] ?? '',
          subtitle: t['author'],
          description: t['tipText'],
          imageUrl: t['authorIconUrl'],
          type: ExploreItemType.tip,
          tags: t['tipType'] != null ? [t['tipType'].toString()] : [],
          categoryIds: (t['categoryId'] as String?)?.isNotEmpty == true
              ? [t['categoryId']]
              : [],
          isFeatured: t['isFeatured'] ?? false,
          isPremium: t['isPremium'] ?? false,
          createdAt: _parseDate(t['createdAt']),
          metadata: {'tipType': t['tipType']?.toString() ?? ''},
        ));
      }

      // Images
      final imageList = (data['images'] as List?) ?? [];
      for (final img in imageList) {
        allItems.add(ExploreItemEntity(
          id: img['id'] ?? '',
          title: img['title'] ?? '',
          subtitle: img['author'],
          description: img['description'],
          imageUrl: img['imageUrl'],
          thumbnailUrl: img['thumbnailUrl'],
          type: ExploreItemType.image,
          tags: const [],
          categoryIds: (img['categoryId'] as String?)?.isNotEmpty == true
              ? [img['categoryId']]
              : [],
          isFeatured: img['isFeatured'] ?? false,
          isPremium: img['isPremium'] ?? false,
          createdAt: _parseDate(img['createdAt']),
        ));
      }

      allItems.sort((a, b) {
        if (a.isFeatured != b.isFeatured) return a.isFeatured ? -1 : 1;
        return b.createdAt.compareTo(a.createdAt);
      });

      return Right(allItems);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch category content: $e'));
    }
  }

  ExploreItemEntity _videoToEntity(Map<String, dynamic> v, ExploreItemType type) {
    return ExploreItemEntity(
      id: v['id'] ?? '',
      title: v['title'] ?? '',
      subtitle: v['artistName'],
      description: v['description'],
      imageUrl: v['coverImageUrl'],
      thumbnailUrl: v['thumbnailUrl'],
      type: type,
      tags: List<String>.from(v['moodTags'] ?? []),
      categoryIds: (v['categoryId'] as String?)?.isNotEmpty == true
          ? [v['categoryId']]
          : [],
      isFeatured: v['isFeatured'] ?? false,
      isPremium: v['isPremium'] ?? false,
      durationSeconds: v['durationSeconds'] as int?,
      createdAt: _parseDate(v['createdAt']),
      metadata: {'videoUrl': v['videoUrl'] ?? ''},
    );
  }

  DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  Future<List<ExploreItemEntity>> _fetchAudioItems() async {
    try {
      // Fetch audio per-category so that categoryId and audioUrl are always
      // populated (the general getAllAudio proto endpoint omits these fields).
      final categories = await _categoryDataSource.getCategories();
      final audioMap = <String, ExploreItemEntity>{};

      await Future.wait(
        categories.map((category) async {
          try {
            final result = await _audioDataSource.getAudioByCategory(
              categoryId: category.id,
              limit: 50,
            );
            for (final track in result.tracks) {
              audioMap.putIfAbsent(
                track.id,
                () => ExploreItemEntity(
                  id: track.id,
                  title: track.title,
                  subtitle: track.artistName,
                  description: track.description,
                  imageUrl: track.coverImageUrl,
                  thumbnailUrl: track.thumbnailUrl,
                  type: ExploreItemType.audio,
                  tags: List<String>.from(track.moodTags),
                  categoryIds: category.id.isNotEmpty ? [category.id] : [],
                  isFeatured: track.isFeatured,
                  isPremium: track.isPremium,
                  durationSeconds: track.durationSeconds,
                  createdAt:
                      DateTime.tryParse(track.createdAt) ?? DateTime.now(),
                  metadata: {'audioUrl': track.audioUrl},
                ),
              );
            }
          } catch (_) {}
        }),
      );

      return audioMap.values.toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ExploreItemEntity>> _fetchVideoItems() async {
    try {
      final shortVideos = await _videoDataSource.getShortVideos(limit: 50);
      final longVideos = await _videoDataSource.getLongVideos(limit: 50);

      final items = <ExploreItemEntity>[];

      for (final video in shortVideos) {
        items.add(ExploreItemEntity(
          id: video.id,
          title: video.title,
          subtitle: video.artistName,
          description: video.description,
          imageUrl: video.coverImageUrl,
          thumbnailUrl: video.thumbnailUrl,
          type: ExploreItemType.shortVideo,
          tags: video.moodTags,
          categoryIds: video.categoryId.isNotEmpty ? [video.categoryId] : [],
          isFeatured: video.isFeatured,
          isPremium: video.isPremium,
          durationSeconds: video.durationSeconds,
          createdAt: video.createdAt,
          metadata: {'videoUrl': video.videoUrl},
        ));
      }

      for (final video in longVideos) {
        items.add(ExploreItemEntity(
          id: video.id,
          title: video.title,
          subtitle: video.artistName,
          description: video.description,
          imageUrl: video.coverImageUrl,
          thumbnailUrl: video.thumbnailUrl,
          type: ExploreItemType.longVideo,
          tags: video.moodTags,
          categoryIds: video.categoryId.isNotEmpty ? [video.categoryId] : [],
          isFeatured: video.isFeatured,
          isPremium: video.isPremium,
          durationSeconds: video.durationSeconds,
          createdAt: video.createdAt,
          metadata: {'videoUrl': video.videoUrl},
        ));
      }

      return items;
    } catch (e) {
      return [];
    }
  }

  Future<List<ExploreItemEntity>> _fetchQuoteItems() async {
    try {
      final result = await _quoteDataSource.listQuotes(limit: 100);
      final quotes = (result['quotes'] as List?)?.cast<QuoteEntity>() ?? [];
      return quotes.map((quote) => ExploreItemEntity(
        id: quote.id,
        title: quote.quoteText,
        subtitle: quote.author,
        imageUrl: quote.authorIconUrl,
        type: ExploreItemType.quote,
        tags: [],
        categoryIds: quote.categoryId != null ? [quote.categoryId!] : [],
        isFeatured: quote.isFeatured,
        isPremium: quote.isPremium,
        createdAt: quote.createdAt,
      )).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ExploreItemEntity>> _fetchTipItems() async {
    try {
      final result = await _tipDataSource.listTips(limit: 100);
      final tips = result.tips;
      return tips.map((tip) => ExploreItemEntity(
        id: tip.id,
        title: tip.title,
        subtitle: tip.author,
        description: tip.tipText,
        imageUrl: tip.authorIconUrl,
        type: ExploreItemType.tip,
        tags: [tip.tipTypeString],
        categoryIds: tip.categoryId.isNotEmpty ? [tip.categoryId] : [],
        isFeatured: tip.isFeatured,
        isPremium: tip.isPremium,
        createdAt: tip.createdAt,
        metadata: {'tipType': tip.tipType.toString()},
      )).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ExploreItemEntity>> _fetchImageItems() async {
    try {
      final result = await _imageDataSource.listImages(limit: 100);
      final images = result.images;
      return images.map((image) => ExploreItemEntity(
        id: image.id,
        title: image.title,
        subtitle: image.author,
        description: image.description,
        imageUrl: image.imageUrl,
        thumbnailUrl: image.thumbnailUrl,
        type: ExploreItemType.image,
        categoryIds: image.categoryId.isNotEmpty ? [image.categoryId] : [],
        isFeatured: image.isFeatured,
        isPremium: image.isPremium,
        createdAt: image.createdAt,
      )).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ExploreItemEntity>> _fetchCategoryItems() async {
    try {
      final categories = await _categoryDataSource.getCategories();
      return categories.map((category) => ExploreItemEntity(
        id: category.id,
        title: category.name,
        description: category.description,
        imageUrl: category.imageUrl,
        type: ExploreItemType.category,
        tags: [],
        categoryIds: [category.id],
        createdAt: category.createdAt,
      )).toList();
    } catch (e) {
      return [];
    }
  }

  ExploreItemEntity _mapAudioToExploreItem(dynamic audio) {
    if (audio is AudioEntity) {
      return ExploreItemEntity(
        id: audio.id,
        title: audio.title,
        subtitle: audio.artistName,
        description: audio.description,
        imageUrl: audio.coverImageUrl,
        thumbnailUrl: audio.thumbnailUrl,
        type: ExploreItemType.audio,
        tags: audio.moodTags,
        categoryIds: audio.categoryId.isNotEmpty ? [audio.categoryId] : [],
        isFeatured: audio.isFeatured,
        isPremium: audio.isPremium,
        durationSeconds: audio.durationSeconds,
        createdAt: audio.createdAt,
        metadata: {'audioUrl': audio.audioUrl},
      );
    } else {
      // Protobuf AudioTrack
      return ExploreItemEntity(
        id: audio.id,
        title: audio.title,
        subtitle: audio.artistName,
        description: audio.description,
        imageUrl: audio.coverImageUrl,
        thumbnailUrl: audio.thumbnailUrl,
        type: ExploreItemType.audio,
        tags: List<String>.from(audio.moodTags),
        categoryIds: audio.categoryId.isNotEmpty ? [audio.categoryId] : [],
        isFeatured: audio.isFeatured,
        isPremium: audio.isPremium,
        durationSeconds: audio.durationSeconds,
        createdAt: DateTime.tryParse(audio.createdAt) ?? DateTime.now(),
        metadata: {'audioUrl': audio.audioUrl},
      );
    }
  }

  @override
  Future<List<String>> getRecentSearches() async {
    return await _localDataSource.getRecentSearches();
  }

  @override
  Future<void> saveRecentSearch(String query) async {
    await _localDataSource.saveRecentSearch(query);
  }

  @override
  Future<void> clearRecentSearches() async {
    await _localDataSource.clearRecentSearches();
  }

  @override
  Future<List<String>> getTrendingSearches() async {
    return _localDataSource.getTrendingSearches();
  }
}