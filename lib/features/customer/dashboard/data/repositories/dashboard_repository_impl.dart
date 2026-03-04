import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/remote/dashboard_remote_data_source.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _remoteDataSource;

  DashboardRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, UserProfile>> getUserProfile(String userId, String idToken) async {
    try {
      final profileData = await _remoteDataSource.getUserProfile(userId, idToken);
      
      if (profileData != null) {
        return Right(profileData);
      } else {
        return Left(ServerFailure('User profile not found'));
      }
    } on NetworkFailure {
      return const Left(NetworkFailure('Failed to fetch user profile'));
    } catch (e) {
      return Left(ServerFailure('Failed to fetch user profile: $e'));
    }
  }
}
