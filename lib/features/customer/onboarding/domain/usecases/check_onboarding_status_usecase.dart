import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:resilio/core/errors/failures.dart';
import 'package:resilio/core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

@injectable
class CheckOnboardingStatusUseCase implements UseCase<bool, NoParams> {
  final OnboardingRepository repository;

  CheckOnboardingStatusUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.isOnboardingCompleted();
  }
}
