import 'package:dartz/dartz.dart';
import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/features/customer/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, ProfileEntity>> updateProfile(ProfileEntity profile);
}
