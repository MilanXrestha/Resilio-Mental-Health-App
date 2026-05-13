import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/remote/dashboard_remote_data_source.dart';

import '../../../../../core/network/network_info.dart';
import '../datasources/local/dashboard_local_data_source.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;
  final DashboardLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  DashboardRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      if (await _networkInfo.isConnected) {
        try {
          final profileData = await _remoteDataSource.getUserProfile();
          if (profileData != null) {
            await _localDataSource.cacheUserProfile(profileData);
            return Right(profileData);
          } else {
            return const Left(ServerFailure('User profile not found'));
          }
        } catch (e) {
          // Network error, try cache
          final cachedProfile = await _localDataSource.getCachedUserProfile();
          if (cachedProfile != null) {
            return Right(cachedProfile);
          }
          return Left(ServerFailure('Failed to fetch user profile: $e'));
        }
      } else {
        // No internet, use cache
        final cachedProfile = await _localDataSource.getCachedUserProfile();
        if (cachedProfile != null) {
          return Right(cachedProfile);
        }
        return const Left(NetworkFailure('No internet connection and no cached profile available'));
      }
    } catch (e) {
      return Left(ServerFailure('Failed to fetch user profile: $e'));
    }
  }
}