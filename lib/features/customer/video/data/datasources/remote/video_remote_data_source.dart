import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/proto_generated/video.pb.dart';
import '../../../domain/entities/video_entity.dart';
import '../../../domain/repositories/video_repository.dart';

abstract class VideoRemoteDataSource {
  Future<List<VideoEntity>> getShortVideos({
    int limit = 20,
    int offset = 0,
  });

  Future<List<VideoEntity>> getLongVideos({
    String? categoryId,
    int limit = 20,
    int offset = 0,
  });

  Future<List<VideoEntity>> getFeaturedVideos({
    int limit = 10,
  });

  Future<VideoEntity> getVideoById(String videoId);

  Future<int> incrementPlayCount(String videoId);
}

@LazySingleton(as: VideoRemoteDataSource)
class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final Dio _dio;

  VideoRemoteDataSourceImpl(this._dio);

  /// Common request options for protobuf
  Options get _protoOptions => Options(
        headers: {
          'Accept': 'application/x-protobuf',
        },
        responseType: ResponseType.bytes,
      );

  @override
  Future<List<VideoEntity>> getShortVideos({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.videoShorts,
        queryParameters: {
          'limit': limit.toString(),
          'offset': offset.toString(),
        },
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = GetVideosResponse.fromBuffer(bytes);

        return result.videos.map(_mapToEntity).toList();
      }

      return [];
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch short videos: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch short videos: $e');
    }
  }

  @override
  Future<List<VideoEntity>> getLongVideos({
    String? categoryId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };

      if (categoryId != null && categoryId.isNotEmpty) {
        queryParams['category_id'] = categoryId;
      }

      final response = await _dio.get(
        ApiEndpoints.videoLong,
        queryParameters: queryParams,
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = GetVideosResponse.fromBuffer(bytes);

        return result.videos.map(_mapToEntity).toList();
      }

      return [];
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch long videos: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch long videos: $e');
    }
  }

  @override
  Future<List<VideoEntity>> getFeaturedVideos({
    int limit = 10,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.videoFeatured,
        queryParameters: {
          'limit': limit.toString(),
        },
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = GetVideosResponse.fromBuffer(bytes);

        return result.videos.map(_mapToEntity).toList();
      }

      return [];
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch featured videos: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch featured videos: $e');
    }
  }

  @override
  Future<VideoEntity> getVideoById(String videoId) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.video}/$videoId',
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = VideoResponse.fromBuffer(bytes);
        return _mapToEntity(result.video);
      }

      throw NetworkFailure('Video not found: ${response.statusCode}');
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch video: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch video: $e');
    }
  }

  @override
  Future<int> incrementPlayCount(String videoId) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.video}/$videoId/play',
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = PlayCountResponse.fromBuffer(bytes);
        return result.newCount;
      }

      throw NetworkFailure(
          'Failed to increment play count: ${response.statusCode}');
    } on DioException catch (e) {
      throw NetworkFailure('Failed to increment play count: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to increment play count: $e');
    }
  }

  /// Map protobuf Video to VideoEntity
  VideoEntity _mapToEntity(Video video) {
    return VideoEntity(
      id: video.id,
      title: video.title,
      description: video.description,
      artistName: video.artistName,
      videoUrl: video.videoUrl,
      thumbnailUrl: video.thumbnailUrl,
      coverImageUrl: video.coverImageUrl,
      durationSeconds: video.durationSeconds,
      categoryId: video.categoryId,
      moodTags: video.moodTags.toList(),
      videoType: _parseVideoType(video.videoType),
      aspectRatio: video.aspectRatio,
      isFeatured: video.isFeatured,
      isPremium: video.isPremium,
      isActive: video.isActive,
      sortOrder: video.sortOrder,
      playCount: video.playCount,
      likeCount: video.likeCount,
      shareCount: video.shareCount,
      createdAt: DateTime.tryParse(video.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(video.updatedAt) ?? DateTime.now(),
    );
  }

  /// Parse video type from string
  VideoType _parseVideoType(String type) {
    switch (type.toLowerCase()) {
      case 'short':
        return VideoType.shortForm;
      case 'long':
        return VideoType.longForm;
      default:
        return VideoType.unknown;
    }
  }
}
