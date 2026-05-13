import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/local/category_local_data_source.dart';
import '../datasources/remote/category_remote_data_source.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      // Try to fetch from remote first if connected
      if (await networkInfo.isConnected) {
        try {
          final remoteCategories = await remoteDataSource.getCategories();
          // Cache the data locally
          await localDataSource.saveCategories(remoteCategories);
          return Right(remoteCategories);
        } catch (e) {
          // Network error, fall back to cache
          final cachedCategories = await localDataSource.getCategories();
          if (cachedCategories.isNotEmpty) {
            return Right(cachedCategories);
          }
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        // No internet, use cached data
        final cachedCategories = await localDataSource.getCategories();
        if (cachedCategories.isNotEmpty) {
          return Right(cachedCategories);
        }
        return const Left(NetworkFailure('No internet connection and no cached data available'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
