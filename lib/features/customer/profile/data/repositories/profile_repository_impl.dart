import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/features/customer/profile/domain/entities/profile_entity.dart';
import 'package:Resilio/features/customer/profile/domain/repositories/profile_repository.dart';
import 'package:Resilio/features/customer/profile/data/datasources/profile_remote_data_source.dart';
import 'package:Resilio/features/customer/profile/data/models/profile_model.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final profile = await _remoteDataSource.getProfile();
      if (profile != null) {
        return Right(profile);
      } else {
        return const Left(ServerFailure('Failed to fetch profile'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure('Network error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity profile) async {
    try {
      final model = ProfileModel(
        id: profile.id,
        firebaseUid: profile.firebaseUid,
        email: profile.email,
        username: profile.username,
        displayName: profile.displayName,
        photoUrl: profile.photoUrl,
        phoneNumber: profile.phoneNumber,
        dateOfBirth: profile.dateOfBirth,
        gender: profile.gender,
        userRole: profile.userRole,
        accountStatus: profile.accountStatus,
        preferencesCompleted: profile.preferencesCompleted,
        fcmToken: profile.fcmToken,
        timezone: profile.timezone,
        language: profile.language,
        createdAt: profile.createdAt,
        updatedAt: profile.updatedAt,
        lastLoginAt: profile.lastLoginAt,
      );
      final updatedProfile = await _remoteDataSource.updateProfile(model);
      if (updatedProfile != null) {
        return Right(updatedProfile);
      } else {
        return const Left(ServerFailure('Failed to update profile'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure('Network error: ${e.message}'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
