import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:resilio/core/errors/failures.dart';
import 'package:resilio/core/network/network_info.dart';
import 'package:resilio/core/proto_generated/auth.pb.dart';
import 'package:resilio/features/customer/auth/data/models/user_mapper.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_data_source.dart';
import '../datasources/remote/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final request = LoginRequest()
          ..email = email
          ..password = password;

        final response = await _remoteDataSource.login(request: request);

        // Cache the user locally
        await _localDataSource.cacheUser(response.user);

        return Right(response.user.toEntity());
      } on DioException catch (e) {
        return Left(ServerFailure(e.message ?? 'Server connection failed'));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      // Offline: try to get from cache
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Right(cachedUser.toEntity());
      }
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _localDataSource.clearCache();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCachedUser() async {
    try {
      final user = await _localDataSource.getCachedUser();
      return Right(user?.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
