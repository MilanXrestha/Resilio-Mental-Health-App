import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/entities/tip_entity.dart';
import '../../domain/repositories/tip_repository.dart';
import '../datasources/local/tips_local_data_source.dart';
import '../datasources/remote/tip_remote_data_source.dart';

@LazySingleton(as: TipRepository)
class TipRepositoryImpl implements TipRepository {
  final TipRemoteDataSource remoteDataSource;
  final TipsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TipRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<TipEntity>>> getFeaturedTips({
    int limit = 10,
    List<String>? preferenceIds,
    String? tipType,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final tips = await remoteDataSource.getFeaturedTips(
            limit: limit,
            preferenceIds: preferenceIds,
            tipType: tipType,
          );
          // Cache the tips
          await localDataSource.saveTips(tips);
          return Right(tips);
        } catch (e) {
          // Network error, try cache
          final cachedTips = await localDataSource.getTips();
          final featured = cachedTips.where((t) => t.isFeatured).toList();
          if (featured.isNotEmpty) {
            return Right(featured);
          }
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        // No internet, use cache
        final cachedTips = await localDataSource.getTips();
        final featured = cachedTips.where((t) => t.isFeatured).toList();
        if (featured.isNotEmpty) {
          return Right(featured);
        }
        return const Left(NetworkFailure('No internet connection and no cached data available'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TipEntity>> getTipById(String tipId) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final tip = await remoteDataSource.getTipById(tipId);
          return Right(tip);
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
  Future<Either<Failure, TipsListResult>> listTips({
    int limit = 20,
    int offset = 0,
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? tipType,
    List<String>? preferenceIds,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final result = await remoteDataSource.listTips(
            limit: limit,
            offset: offset,
            categoryId: categoryId,
            isFeatured: isFeatured,
            isPremium: isPremium,
            tipType: tipType,
            preferenceIds: preferenceIds,
          );
          // Cache the tips
          await localDataSource.saveTips(result.tips);
          return Right(result);
        } catch (e) {
          // Network error, try cache
          final cachedTips = await localDataSource.getTips(categoryId: categoryId);
          if (cachedTips.isNotEmpty) {
            return Right(TipsListResult(tips: cachedTips, totalCount: cachedTips.length));
          }
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        // No internet, use cache
        final cachedTips = await localDataSource.getTips(categoryId: categoryId);
        if (cachedTips.isNotEmpty) {
          return Right(TipsListResult(tips: cachedTips, totalCount: cachedTips.length));
        }
        return const Left(NetworkFailure('No internet connection and no cached data available'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TipsListResult>> getTipsByType({
    required String tipType,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        try {
          final result = await remoteDataSource.getTipsByType(
            tipType: tipType,
            limit: limit,
            offset: offset,
          );
          // Cache the tips
          await localDataSource.saveTips(result.tips);
          return Right(result);
        } catch (e) {
          // Network error, try cache
          final cachedTips = await localDataSource.getTips();
          if (cachedTips.isNotEmpty) {
            return Right(TipsListResult(tips: cachedTips, totalCount: cachedTips.length));
          }
          return Left(NetworkFailure(e.toString()));
        }
      } else {
        // No internet, use cache
        final cachedTips = await localDataSource.getTips();
        if (cachedTips.isNotEmpty) {
          return Right(TipsListResult(tips: cachedTips, totalCount: cachedTips.length));
        }
        return const Left(NetworkFailure('No internet connection and no cached data available'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
