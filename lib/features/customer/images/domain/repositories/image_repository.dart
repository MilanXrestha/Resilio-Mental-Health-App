import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/image_entity.dart';

abstract class ImageRepository {
  /// Get featured images (for dashboard)
  Future<Either<Failure, List<ImageEntity>>> getFeaturedImages({
    int limit = 10,
    List<String>? preferenceIds,
    String? imageType,
  });

  /// Get image by ID
  Future<Either<Failure, ImageEntity>> getImageById(String imageId);

  /// List all images with pagination
  Future<Either<Failure, ImagesListResult>> listImages({
    int limit = 20,
    int offset = 0,
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? imageType,
    List<String>? preferenceIds,
  });

  /// Get images by type
  Future<Either<Failure, ImagesListResult>> getImagesByType({
    required String imageType,
    int limit = 20,
    int offset = 0,
  });
}

/// Result containing list of images and total count
class ImagesListResult {
  final List<ImageEntity> images;
  final int totalCount;

  const ImagesListResult({
    required this.images,
    required this.totalCount,
  });
}
