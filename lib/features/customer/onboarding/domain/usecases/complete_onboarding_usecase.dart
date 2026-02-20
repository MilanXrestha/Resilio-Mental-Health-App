import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:resilio/core/errors/failures.dart';
import 'package:resilio/core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

@injectable
class CompleteOnboardingUseCase implements UseCase<void, NoParams> {
  final OnboardingRepository repository;

  CompleteOnboardingUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.markOnboardingCompleted();
  }
}
