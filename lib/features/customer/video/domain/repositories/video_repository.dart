import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/video_entity.dart';
import '../entities/video_comment_entity.dart';

abstract class VideoRepository {
  Future<Either<Failure, List<VideoEntity>>> getShortVideos({
    int limit = 20,
    int offset = 0,
    bool? isFeatured,
  });

  Future<Either<Failure, List<VideoEntity>>> getLongVideos({
    String? categoryId,
    int limit = 20,
    int offset = 0,
    bool? isFeatured,
  });

  Future<Either<Failure, List<VideoEntity>>> getFeaturedVideos({
    int limit = 10,
  });

  Future<Either<Failure, VideoEntity>> getVideoById(String videoId);

  Future<Either<Failure, int>> incrementPlayCount(String videoId);

  Future<Either<Failure, List<VideoCommentEntity>>> getVideoComments(
      String videoId);

  Future<Either<Failure, VideoCommentEntity>> addVideoComment({
    required String videoId,
    required String userId,
    required String content,
  });
}
