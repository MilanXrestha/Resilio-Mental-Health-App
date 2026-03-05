import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/tip_entity.dart';
import '../../domain/repositories/tip_repository.dart';
import '../datasources/remote/tip_remote_data_source.dart';

@LazySingleton(as: TipRepository)
class TipRepositoryImpl implements TipRepository {
  final TipRemoteDataSource remoteDataSource;

  TipRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<TipEntity>>> getFeaturedTips({
    int limit = 10,
    List<String>? preferenceIds,
    String? tipType,
  }) async {
    try {
      final tips = await remoteDataSource.getFeaturedTips(
        limit: limit,
        preferenceIds: preferenceIds,
        tipType: tipType,
      );
      return Right(tips);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TipEntity>> getTipById(String tipId) async {
    try {
      final tip = await remoteDataSource.getTipById(tipId);
      return Right(tip);
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
      final result = await remoteDataSource.listTips(
        limit: limit,
        offset: offset,
        categoryId: categoryId,
        isFeatured: isFeatured,
        isPremium: isPremium,
        tipType: tipType,
        preferenceIds: preferenceIds,
      );
      return Right(result);
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
      final result = await remoteDataSource.getTipsByType(
        tipType: tipType,
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
