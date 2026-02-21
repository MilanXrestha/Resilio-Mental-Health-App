import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

@injectable
class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _repository.logout();
  }
}
