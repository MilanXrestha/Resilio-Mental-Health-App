import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/image_entity.dart';
import '../../domain/repositories/image_repository.dart';
import '../datasources/remote/image_remote_data_source.dart';

import '../../../../../core/network/network_info.dart';
import '../datasources/local/image_local_data_source.dart';

@LazySingleton(as: ImageRepository)
class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource remoteDataSource;
  final ImageLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ImageRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<ImageEntity>>> getFeaturedImages({
    int limit = 10,
    List<String>? preferenceIds,
    String? imageType,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final result = await remoteDataSource.getFeaturedImages(
            limit: limit,
            preferenceIds: preferenceIds,
            imageType: imageType,
          );
          await localDataSource.cacheImages(result);
          return Right(result);
        } catch (e) {
          final cached = await localDataSource.getCachedImages();
          if (cached.isNotEmpty) {
            return Right(cached.where((img) => img.isFeatured).toList());
          }
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        final cached = await localDataSource.getCachedImages();
        if (cached.isNotEmpty) {
          return Right(cached.where((img) => img.isFeatured).toList());
        }
        return const Left(
          NetworkFailure(
            'No internet connection and no cached images available',
          ),
        );
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ImageEntity>> getImageById(String imageId) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getImageById(imageId);
        return Right(result);
      } else {
        final cached = await localDataSource.getCachedImages();
        final img = cached.firstWhere((i) => i.id == imageId);
        return Right(img);
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ImagesListResult>> listImages({
    int limit = 20,
    int offset = 0,
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? imageType,
    List<String>? preferenceIds,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final result = await remoteDataSource.listImages(
            limit: limit,
            offset: offset,
            categoryId: categoryId,
            isFeatured: isFeatured,
            isPremium: isPremium,
            imageType: imageType,
            preferenceIds: preferenceIds,
          );
          await localDataSource.cacheImages(result.images);
          return Right(result);
        } catch (e) {
          final cached = await localDataSource.getCachedImages();
          if (cached.isNotEmpty) {
            return Right(
              ImagesListResult(images: cached, totalCount: cached.length),
            );
          }
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        final cached = await localDataSource.getCachedImages();
        if (cached.isNotEmpty) {
          return Right(
            ImagesListResult(images: cached, totalCount: cached.length),
          );
        }
        return const Left(
          NetworkFailure(
            'No internet connection and no cached images available',
          ),
        );
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ImagesListResult>> getImagesByType({
    required String imageType,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final result = await remoteDataSource.getImagesByType(
            imageType: imageType,
            limit: limit,
            offset: offset,
          );
          await localDataSource.cacheImages(result.images);
          return Right(result);
        } catch (e) {
          final cached = await localDataSource.getCachedImages();
          final filtered = _filterByImageType(cached, imageType);
          if (filtered.isNotEmpty) {
            return Right(
              ImagesListResult(images: filtered, totalCount: filtered.length),
            );
          }
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        final cached = await localDataSource.getCachedImages();
        final filtered = _filterByImageType(cached, imageType);
        if (filtered.isNotEmpty) {
          return Right(
            ImagesListResult(images: filtered, totalCount: filtered.length),
          );
        }
        return const Left(
          NetworkFailure(
            'No internet connection and no cached images available',
          ),
        );
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  List<ImageEntity> _filterByImageType(
    List<ImageEntity> images,
    String imageType,
  ) {
    final normalizedType = imageType.toLowerCase();
    return images
        .where(
          (img) =>
              img.imageType.name.toLowerCase() == normalizedType ||
              img.imageTypeString.toLowerCase() == normalizedType,
        )
        .toList();
  }
}
