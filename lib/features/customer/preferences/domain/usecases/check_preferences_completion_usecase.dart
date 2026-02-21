import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/usecases/usecase.dart';
import '../repositories/preference_repository.dart';

/// Use case to check if user has completed preferences
@injectable
class CheckPreferencesCompletionUseCase implements UseCase<bool, NoParams> {
  final PreferenceRepository _repository;

  CheckPreferencesCompletionUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return _repository.hasCompletedPreferences();
  }
}
