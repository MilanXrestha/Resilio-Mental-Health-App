import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/network/network_info.dart';
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
  final FirebaseAuth _firebaseAuth;

  PreferenceRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
    this._firebaseAuth,
  );

  Future<String?> _getIdToken() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return await user.getIdToken();
  }

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
      // Fallback to cache even on server failure if we have data
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
      final idToken = await _getIdToken();
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
      final idToken = await _getIdToken();
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
      
      // Update local cache on successful save
      await _localDataSource.cacheUserPreferences(data);
      // Also potentially update completion status if we know it should be true now
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
      final idToken = await _getIdToken();
      if (idToken == null) {
        return const Left(ServerFailure('User not authenticated'));
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

  PreferenceEntity _mapToPreferenceEntity(Map<String, dynamic> json) {
    return PreferenceEntity(
      id: json['id'] ?? '',
      preferenceId: json['preferenceId'] ?? '',
      preferenceName: json['preferenceName'] ?? '',
      preferenceDescription: json['preferenceDescription'] ?? '',
      preferenceIcon: (json['preferenceIcon'] as String? ?? '').trim(),
      isSvg: json['isSvg'] ?? false,
      sortOrder: json['sortOrder'] ?? 0,
      isActive: json['isActive'] ?? true,
    );
  }

  UserPreferenceWithDetailsEntity _mapToUserPreferenceWithDetails(Map<String, dynamic> json) {
    return UserPreferenceWithDetailsEntity(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      preference: _mapToPreferenceEntity(json['preference'] ?? {}),
      selectedAt: json['selectedAt'] != null ? DateTime.tryParse(json['selectedAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}

