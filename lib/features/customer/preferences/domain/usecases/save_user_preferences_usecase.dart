import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/usecases/usecase.dart';
import '../entities/user_preference_entity.dart';
import '../repositories/preference_repository.dart';

/// Parameters for saving user preferences
class SaveUserPreferencesParams extends Equatable {
  final List<String> preferenceIds;

  const SaveUserPreferencesParams({
    required this.preferenceIds,
  });

  @override
  List<Object?> get props => [preferenceIds];
}

/// Use case to save user preferences
@injectable
class SaveUserPreferencesUseCase implements UseCase<List<UserPreferenceWithDetailsEntity>, SaveUserPreferencesParams> {
  final PreferenceRepository _repository;

  SaveUserPreferencesUseCase(this._repository);

  @override
  Future<Either<Failure, List<UserPreferenceWithDetailsEntity>>> call(SaveUserPreferencesParams params) async {
    return _repository.saveUserPreferences(params.preferenceIds);
  }
}
