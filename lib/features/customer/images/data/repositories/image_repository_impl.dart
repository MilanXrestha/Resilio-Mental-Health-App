import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/image_entity.dart';
import '../../domain/repositories/image_repository.dart';
import '../datasources/remote/image_remote_data_source.dart';

@LazySingleton(as: ImageRepository)
class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource remoteDataSource;

  ImageRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ImageEntity>>> getFeaturedImages({
    int limit = 10,
    List<String>? preferenceIds,
    String? imageType,
  }) async {
    try {
      final result = await remoteDataSource.getFeaturedImages(
        limit: limit,
        preferenceIds: preferenceIds,
        imageType: imageType,
      );
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ImageEntity>> getImageById(String imageId) async {
    try {
      final result = await remoteDataSource.getImageById(imageId);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
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
      final result = await remoteDataSource.listImages(
        limit: limit,
        offset: offset,
        categoryId: categoryId,
        isFeatured: isFeatured,
        isPremium: isPremium,
        imageType: imageType,
        preferenceIds: preferenceIds,
      );
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
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
      final result = await remoteDataSource.getImagesByType(
        imageType: imageType,
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
