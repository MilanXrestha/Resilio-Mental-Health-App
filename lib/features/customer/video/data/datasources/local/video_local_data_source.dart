import 'package:injectable/injectable.dart';
import '../../../../../../core/database/database_helper.dart';
import '../../../domain/entities/video_entity.dart';

abstract class VideoLocalDataSource {
  Future<List<VideoEntity>> getShortVideos({String? categoryId});
  Future<List<VideoEntity>> getLongVideos({String? categoryId});
  Future<void> saveVideos(List<VideoEntity> videos);
  Future<void> clearVideos();
  Future<bool> isCacheValid();
}

@LazySingleton(as: VideoLocalDataSource)
class VideoLocalDataSourceImpl implements VideoLocalDataSource {
  final DatabaseHelper databaseHelper;

  VideoLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<VideoEntity>> getShortVideos({String? categoryId}) async {
    final maps = await databaseHelper.getVideos(categoryId: categoryId);
    return maps
        .where((map) => map['videoType'] == VideoType.shortForm.toString())
        .map(_mapToVideoEntity)
        .toList();
  }

  @override
  Future<List<VideoEntity>> getLongVideos({String? categoryId}) async {
    final maps = await databaseHelper.getVideos(categoryId: categoryId);
    return maps
        .where((map) => map['videoType'] == VideoType.longForm.toString())
        .map(_mapToVideoEntity)
        .toList();
  }

  @override
  Future<void> saveVideos(List<VideoEntity> videos) async {
    final maps = videos.map((video) {
      return {
        'id': video.id,
        'title': video.title,
        'description': video.description,
        'categoryId': video.categoryId,
        'videoUrl': video.videoUrl,
        'thumbnailUrl': video.thumbnailUrl,
        'coverImageUrl': video.coverImageUrl,
        'durationSeconds': video.durationSeconds,
        'artistName': video.artistName,
        'videoType': video.videoType.toString(),
        'aspectRatio': video.aspectRatio,
        'isFeatured': video.isFeatured,
        'isPremium': video.isPremium,
        'isActive': video.isActive,
        'sortOrder': video.sortOrder,
        'moodTags': video.moodTags,
        'playCount': video.playCount,
        'likeCount': video.likeCount,
        'shareCount': video.shareCount,
        'createdAt': video.createdAt.toIso8601String(),
        'updatedAt': video.updatedAt.toIso8601String(),
      };
    }).toList();

    await databaseHelper.saveVideos(maps);
    await databaseHelper.updateSyncMetadata('videos', DatabaseHelper.cacheValidityDefault);
  }

  @override
  Future<void> clearVideos() async {
    await databaseHelper.clearVideos();
  }

  @override
  Future<bool> isCacheValid() async {
    return await databaseHelper.shouldSync('videos') == false;
  }

  VideoEntity _mapToVideoEntity(Map<String, dynamic> map) {
    return VideoEntity(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      artistName: map['artistName'] as String? ?? '',
      videoUrl: map['videoUrl'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
      coverImageUrl: map['coverImageUrl'] as String? ?? '',
      durationSeconds: map['durationSeconds'] as int? ?? 0,
      categoryId: map['categoryId'] as String? ?? '',
      moodTags: List<String>.from(map['moodTags'] as List? ?? []),
      videoType: _parseVideoType(map['videoType'] as String?),
      aspectRatio: (map['aspectRatio'] as num?)?.toDouble() ?? 16.0 / 9.0,
      isFeatured: (map['isFeatured'] as int? ?? 0) == 1,
      isPremium: (map['isPremium'] as int? ?? 0) == 1,
      isActive: (map['isActive'] as int? ?? 1) == 1,
      sortOrder: map['sortOrder'] as int? ?? 0,
      playCount: map['playCount'] as int? ?? 0,
      likeCount: map['likeCount'] as int? ?? 0,
      shareCount: map['shareCount'] as int? ?? 0,
      createdAt: DateTime.parse(map['createdAt'] as String? ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] as String? ?? DateTime.now().toIso8601String()),
    );
  }

  VideoType _parseVideoType(String? type) {
    if (type == null) return VideoType.unknown;
    if (type.contains('shortForm')) return VideoType.shortForm;
    if (type.contains('longForm')) return VideoType.longForm;
    return VideoType.unknown;
  }
}
