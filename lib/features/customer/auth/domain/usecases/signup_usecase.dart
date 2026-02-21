import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(SignUpParams params) {
    return _repository.signUp(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String? name;

  SignUpParams({
    required this.email,
    required this.password,
    this.name,
  });
}
