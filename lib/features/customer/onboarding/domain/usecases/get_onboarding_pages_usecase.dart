import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:resilio/core/errors/failures.dart';
import 'package:resilio/core/usecases/usecase.dart';
import '../entities/onboarding_entity.dart';
import '../repositories/onboarding_repository.dart';

@injectable
class GetOnboardingPagesUseCase implements UseCase<List<OnboardingEntity>, NoParams> {
  final OnboardingRepository repository;

  GetOnboardingPagesUseCase(this.repository);

  @override
  Future<Either<Failure, List<OnboardingEntity>>> call(NoParams params) {
    return repository.getOnboardingPages();
  }
}
