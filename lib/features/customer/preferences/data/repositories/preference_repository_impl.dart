import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/network/network_info.dart';
import 'package:Resilio/core/proto_generated/user.pb.dart' as proto;
import 'package:Resilio/core/services/auth_token_service.dart';
import '../../domain/entities/preference_entity.dart';
import '../../domain/entities/user_preference_entity.dart';
import '../../domain/repositories/preference_repository.dart';
import '../datasources/local/preference_local_data_source.dart';
import '../datasources/remote/preference_remote_data_source.dart';

@LazySingleton(as: PreferenceRepository)
class PreferenceRepositoryImpl implements PreferenceRepository {
  final PreferenceRemoteDataSource _remoteDataSource;
  final PreferenceLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final AuthTokenService _authTokenService;

  PreferenceRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
    this._authTokenService,
  );

  // Sync getter — works for both Firebase and SuperTokens users
  String? _getIdToken() => _authTokenService.token;

  @override
  Future<Either<Failure, List<PreferenceEntity>>> getAllPreferences() async {
    try {
      if (await _networkInfo.isConnected) {
        final data = await _remoteDataSource.getAllPreferences();
        await _localDataSource.cacheAllPreferences(data);
        return Right(data.map(_mapToPreferenceEntity).toList());
      } else {
        final cachedData = await _localDataSource.getCachedAllPreferences();
        if (cachedData != null) {
          return Right(cachedData.map(_mapToPreferenceEntity).toList());
        }
        return const Left(ServerFailure('No internet connection and no cached data available.'));
      }
    } on ServerFailure catch (e) {
      final cachedData = await _localDataSource.getCachedAllPreferences();
      if (cachedData != null) {
        return Right(cachedData.map(_mapToPreferenceEntity).toList());
      }
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Failed to get preferences: $e'));
    }
  }

  @override
  Future<Either<Failure, List<UserPreferenceWithDetailsEntity>>> getUserPreferences() async {
    try {
      final idToken = _getIdToken();
      if (idToken == null) {
        return const Left(ServerFailure('User not authenticated'));
      }

      if (await _networkInfo.isConnected) {
        final data = await _remoteDataSource.getUserPreferences(idToken: idToken);
        await _localDataSource.cacheUserPreferences(data);
        return Right(data.map(_mapToUserPreferenceWithDetails).toList());
      } else {
        final cachedData = await _localDataSource.getCachedUserPreferences();
        if (cachedData != null) {
          return Right(cachedData.map(_mapToUserPreferenceWithDetails).toList());
        }
        return const Left(ServerFailure('No internet connection and no cached data available.'));
      }
    } on ServerFailure catch (e) {
      final cachedData = await _localDataSource.getCachedUserPreferences();
      if (cachedData != null) {
        return Right(cachedData.map(_mapToUserPreferenceWithDetails).toList());
      }
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Failed to get user preferences: $e'));
    }
  }

  @override
  Future<Either<Failure, List<UserPreferenceWithDetailsEntity>>> saveUserPreferences(
    List<String> preferenceIds,
  ) async {
    try {
      final idToken = _getIdToken();
      if (idToken == null) {
        return const Left(ServerFailure('User not authenticated'));
      }

      if (!(await _networkInfo.isConnected)) {
        return const Left(ServerFailure('No internet connection. Please try again later.'));
      }

      final data = await _remoteDataSource.saveUserPreferences(
        idToken: idToken,
        preferenceIds: preferenceIds,
      );
      
      await _localDataSource.cacheUserPreferences(data);
      await _localDataSource.cacheCompletionStatus(true);
      
      return Right(data.map(_mapToUserPreferenceWithDetails).toList());
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Failed to save preferences: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasCompletedPreferences() async {
    try {
      final idToken = _getIdToken();
      if (idToken == null) {
        // Fall back to cached status for ST users on first load
        final cachedStatus = await _localDataSource.getCachedCompletionStatus();
        return Right(cachedStatus ?? false);
      }

      if (await _networkInfo.isConnected) {
        final completed = await _remoteDataSource.hasCompletedPreferences(idToken: idToken);
        await _localDataSource.cacheCompletionStatus(completed);
        return Right(completed);
      } else {
        final cachedStatus = await _localDataSource.getCachedCompletionStatus();
        if (cachedStatus != null) {
          return Right(cachedStatus);
        }
        return const Left(ServerFailure('No internet connection and no cached status available.'));
      }
    } on ServerFailure catch (e) {
      final cachedStatus = await _localDataSource.getCachedCompletionStatus();
      if (cachedStatus != null) {
        return Right(cachedStatus);
      }
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Failed to check preferences completion: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> clearLocalData() async {
    try {
      await _localDataSource.clearCache();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to clear local preferences: $e'));
    }
  }

  PreferenceEntity _mapToPreferenceEntity(proto.Preference p) {
    return PreferenceEntity(
      id: p.id,
      preferenceId: p.preferenceId,
      preferenceName: p.preferenceName,
      preferenceDescription: p.preferenceDescription,
      preferenceIcon: p.preferenceIcon.trim(),
      isSvg: p.isSvg,
      sortOrder: p.sortOrder,
      isActive: p.isActive,
    );
  }

  UserPreferenceWithDetailsEntity _mapToUserPreferenceWithDetails(proto.Preference p) {
    // Note: The protobuf message structure for user preferences might need to be refined
    // If we only return detailed preferences, we map them here.
    return UserPreferenceWithDetailsEntity(
      id: p.id,
      userId: '', // This would need to come from elsewhere if needed
      preference: _mapToPreferenceEntity(p),
      selectedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
