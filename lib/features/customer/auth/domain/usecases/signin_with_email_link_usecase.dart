import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Parameters for signing in with email link
class SignInWithEmailLinkParams {
  final String email;
  final String link;

  const SignInWithEmailLinkParams({
    required this.email,
    required this.link,
  });
}

/// Use case for signing in with email link (passwordless)
@lazySingleton
class SignInWithEmailLinkUseCase implements UseCase<UserEntity, SignInWithEmailLinkParams> {
  final AuthRepository _authRepository;

  SignInWithEmailLinkUseCase(this._authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInWithEmailLinkParams params) async {
    return await _authRepository.signInWithEmailLink(
      email: params.email,
      link: params.link,
    );
  }
}
