import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../audio/data/datasources/audio_remote_datasource.dart';
import '../../../audio/domain/entities/audio_entity.dart';
import '../../../categories/data/datasources/remote/category_remote_data_source.dart';
import '../../../dashboard/data/datasources/remote/quote_remote_data_source.dart';
import '../../../images/data/datasources/remote/image_remote_data_source.dart';
import '../../../tips/data/datasources/remote/tip_remote_data_source.dart';
import '../../../video/data/datasources/remote/video_remote_data_source.dart';
import '../../domain/entities/explore_item_entity.dart';
import '../../domain/repositories/explore_repository.dart';
import '../datasources/explore_local_data_source.dart';

@LazySingleton(as: ExploreRepository)
class ExploreRepositoryImpl implements ExploreRepository {
  final AudioRemoteDataSource _audioDataSource;
  final VideoRemoteDataSource _videoDataSource;
  final QuoteRemoteDataSource _quoteDataSource;
  final TipRemoteDataSource _tipDataSource;
  final ImageRemoteDataSource _imageDataSource;
  final CategoryRemoteDataSource _categoryDataSource;
  final ExploreLocalDataSource _localDataSource;

  ExploreRepositoryImpl(
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
      final List<ExploreItemEntity> allItems = [];

      // Fetch all content types in parallel
      final results = await Future.wait([
        _fetchAudioItems(),
        _fetchVideoItems(),
        _fetchQuoteItems(),
        _fetchTipItems(),
        _fetchImageItems(),
        _fetchCategoryItems(),
      ]);

      for (final items in results) {
        allItems.addAll(items);
      }

      // Sort by creation date (newest first) and featured status
      allItems.sort((a, b) {
        if (a.isFeatured != b.isFeatured) {
          return a.isFeatured ? -1 : 1;
        }
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

  Future<List<ExploreItemEntity>> _fetchAudioItems() async {
    try {
      final tracks = await _audioDataSource.getFeaturedAudio(limit: 50);
      return tracks.map((track) => _mapAudioToExploreItem(track as AudioEntity)).toList();
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
      final quotes = await _quoteDataSource.getFeaturedQuotes(limit: 50);
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
      final tips = await _tipDataSource.getFeaturedTips(limit: 50);
      return tips.map((tip) => ExploreItemEntity(
        id: tip.id,
        title: tip.title,
        subtitle: tip.author,
        description: tip.tipText,
        imageUrl: tip.authorIconUrl,
        type: ExploreItemType.tip,
        tags: [tip.tipTypeString],
        categoryIds: tip.categoryId != null ? [tip.categoryId!] : [],
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
      final images = await _imageDataSource.getFeaturedImages(limit: 50);
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

  ExploreItemEntity _mapAudioToExploreItem(AudioEntity audio) {
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