import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/usecases/usecase.dart';
import '../entities/preference_entity.dart';
import '../repositories/preference_repository.dart';

/// Use case to get all available preferences
@injectable
class GetPreferencesUseCase implements UseCase<List<PreferenceEntity>, NoParams> {
  final PreferenceRepository _repository;

  GetPreferencesUseCase(this._repository);

  @override
  Future<Either<Failure, List<PreferenceEntity>>> call(NoParams params) async {
    return _repository.getAllPreferences();
  }
}
