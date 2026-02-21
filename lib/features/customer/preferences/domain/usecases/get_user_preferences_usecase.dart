import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/usecases/usecase.dart';
import '../entities/user_preference_entity.dart';
import '../repositories/preference_repository.dart';

/// Use case to get user's selected preferences
@injectable
class GetUserPreferencesUseCase implements UseCase<List<UserPreferenceWithDetailsEntity>, NoParams> {
  final PreferenceRepository _repository;

  GetUserPreferencesUseCase(this._repository);

  @override
  Future<Either<Failure, List<UserPreferenceWithDetailsEntity>>> call(NoParams params) async {
    return _repository.getUserPreferences();
  }
}
