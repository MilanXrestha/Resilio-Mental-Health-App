import 'package:dartz/dartz.dart';
import 'package:resilio/core/errors/failures.dart';
import '../entities/onboarding_entity.dart';

abstract class OnboardingRepository {
  /// Get list of onboarding pages
  Future<Either<Failure, List<OnboardingEntity>>> getOnboardingPages();

  /// Check if onboarding has been completed
  Future<Either<Failure, bool>> isOnboardingCompleted();

  /// Mark onboarding as completed
  Future<Either<Failure, void>> markOnboardingCompleted();

  /// Reset onboarding status (for testing/debugging)
  Future<Either<Failure, void>> resetOnboardingStatus();
}
