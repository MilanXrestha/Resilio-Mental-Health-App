import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/entities/video_comment_entity.dart';
import '../../domain/repositories/video_repository.dart';
import '../datasources/local/video_local_data_source.dart';
import '../datasources/remote/video_remote_data_source.dart';

@LazySingleton(as: VideoRepository)
class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;
  final VideoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  VideoRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<VideoEntity>>> getShortVideos({
    int limit = 20,
    int offset = 0,
    bool? isFeatured,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final videos = await remoteDataSource.getShortVideos(
            limit: limit,
            offset: offset,
            isFeatured: isFeatured,
          );
          // Cache the videos
          await localDataSource.saveVideos(videos);
          return Right(videos);
        } catch (e) {
          // Network error, try cache
          final cachedVideos = await localDataSource.getShortVideos();
          final filtered = _filterFeatured(cachedVideos, isFeatured);
          if (filtered.isNotEmpty) {
            return Right(filtered);
          }
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        // No internet, use cache
        final cachedVideos = await localDataSource.getShortVideos();
        final filtered = _filterFeatured(cachedVideos, isFeatured);
        if (filtered.isNotEmpty) {
          return Right(filtered);
        }
        return const Left(
          NetworkFailure('No internet connection and no cached data available'),
        );
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getLongVideos({
    String? categoryId,
    int limit = 20,
    int offset = 0,
    bool? isFeatured,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final videos = await remoteDataSource.getLongVideos(
            categoryId: categoryId,
            limit: limit,
            offset: offset,
            isFeatured: isFeatured,
          );
          // Cache the videos
          await localDataSource.saveVideos(videos);
          return Right(videos);
        } catch (e) {
          // Network error, try cache
          final cachedVideos = await localDataSource.getLongVideos(
            categoryId: categoryId,
          );
          final filtered = _filterFeatured(cachedVideos, isFeatured);
          if (filtered.isNotEmpty) {
            return Right(filtered);
          }
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        // No internet, use cache
        final cachedVideos = await localDataSource.getLongVideos(
          categoryId: categoryId,
        );
        final filtered = _filterFeatured(cachedVideos, isFeatured);
        if (filtered.isNotEmpty) {
          return Right(filtered);
        }
        return const Left(
          NetworkFailure('No internet connection and no cached data available'),
        );
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getFeaturedVideos({
    int limit = 10,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final videos = await remoteDataSource.getFeaturedVideos(limit: limit);
          // Cache the videos
          await localDataSource.saveVideos(videos);
          return Right(videos);
        } catch (e) {
          // Network error, try cache
          final cachedVideos = [
            ...await localDataSource.getShortVideos(),
            ...await localDataSource.getLongVideos(),
          ];
          final featured = cachedVideos.where((v) => v.isFeatured).toList();
          if (featured.isNotEmpty) {
            return Right(featured);
          }
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        // No internet, use cache
        final cachedVideos = [
          ...await localDataSource.getShortVideos(),
          ...await localDataSource.getLongVideos(),
        ];
        final featured = cachedVideos.where((v) => v.isFeatured).toList();
        if (featured.isNotEmpty) {
          return Right(featured);
        }
        return const Left(
          NetworkFailure('No internet connection and no cached data available'),
        );
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VideoEntity>> getVideoById(String videoId) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final video = await remoteDataSource.getVideoById(videoId);
          return Right(video);
        } catch (e) {
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        final cachedVideos = [
          ...await localDataSource.getShortVideos(),
          ...await localDataSource.getLongVideos(),
        ];
        final matchingVideos = cachedVideos.where((v) => v.id == videoId);
        final video = matchingVideos.isEmpty ? null : matchingVideos.first;
        if (video != null) {
          return Right(video);
        }
        return Left(
          const NetworkFailure(
            'No internet connection and video is not cached',
          ),
        );
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> incrementPlayCount(String videoId) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final count = await remoteDataSource.incrementPlayCount(videoId);
          return Right(count);
        } catch (e) {
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        return Left(const NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VideoCommentEntity>>> getVideoComments(
    String videoId,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final comments = await remoteDataSource.getVideoComments(videoId);
          return Right(comments);
        } catch (e) {
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        return Left(const NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VideoCommentEntity>> addVideoComment({
    required String videoId,
    required String userId,
    required String content,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final comment = await remoteDataSource.addVideoComment(
            videoId: videoId,
            userId: userId,
            content: content,
          );
          return Right(comment);
        } catch (e) {
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        return Left(const NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  List<VideoEntity> _filterFeatured(
    List<VideoEntity> videos,
    bool? isFeatured,
  ) {
    if (isFeatured == null) return videos;
    return videos.where((video) => video.isFeatured == isFeatured).toList();
  }
}
