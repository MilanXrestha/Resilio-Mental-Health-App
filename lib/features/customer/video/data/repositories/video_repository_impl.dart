import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/entities/video_comment_entity.dart';
import '../../domain/repositories/video_repository.dart';
import '../datasources/remote/video_remote_data_source.dart';

@LazySingleton(as: VideoRepository)
class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;

  VideoRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<VideoEntity>>> getShortVideos({
    int limit = 20,
    int offset = 0,
    bool? isFeatured,
  }) async {
    try {
      final videos = await remoteDataSource.getShortVideos(
        limit: limit,
        offset: offset,
        isFeatured: isFeatured,
      );
      return Right(videos);
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
      final videos = await remoteDataSource.getLongVideos(
        categoryId: categoryId,
        limit: limit,
        offset: offset,
        isFeatured: isFeatured,
      );
      return Right(videos);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getFeaturedVideos({
    int limit = 10,
  }) async {
    try {
      final videos = await remoteDataSource.getFeaturedVideos(limit: limit);
      return Right(videos);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VideoEntity>> getVideoById(String videoId) async {
    try {
      final video = await remoteDataSource.getVideoById(videoId);
      return Right(video);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> incrementPlayCount(String videoId) async {
    try {
      final count = await remoteDataSource.incrementPlayCount(videoId);
      return Right(count);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VideoCommentEntity>>> getVideoComments(
      String videoId) async {
    try {
      final comments = await remoteDataSource.getVideoComments(videoId);
      return Right(comments);
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
      final comment = await remoteDataSource.addVideoComment(
        videoId: videoId,
        userId: userId,
        content: content,
      );
      return Right(comment);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
