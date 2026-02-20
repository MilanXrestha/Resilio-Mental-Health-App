import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/localization/l10.dart';
import '../../domain/entities/onboarding_entity.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';
import '../models/onboarding_model.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<OnboardingEntity>>> getOnboardingPages() async {
    try {
      final pages = [
        OnboardingModel(
          lottieAsset: 'assets/animations/welcome.json',
          title: l10.onboardingTitle1,
          description: l10.onboardingDescription1,
        ),
        OnboardingModel(
          lottieAsset: 'assets/animations/meditation.json',
          title: l10.onboardingTitle2,
          description: l10.onboardingDescription2,
        ),
        OnboardingModel(
          lottieAsset: 'assets/animations/share.json',
          title: l10.onboardingTitle3,
          description: l10.onboardingDescription3,
        ),
        OnboardingModel(
          lottieAsset: 'assets/animations/rocket.json',
          title: l10.onboardingTitle4,
          description: l10.onboardingDescription4,
        ),
      ];
      return Right(pages.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isOnboardingCompleted() async {
    try {
      final result = await localDataSource.isOnboardingCompleted();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markOnboardingCompleted() async {
    try {
      await localDataSource.markOnboardingCompleted();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetOnboardingStatus() async {
    try {
      await localDataSource.resetOnboardingStatus();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
