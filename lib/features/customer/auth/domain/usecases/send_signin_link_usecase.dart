import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

/// Parameters for sending sign-in link to email
class SendSignInLinkParams {
  final String email;
  final String appUrl;

  const SendSignInLinkParams({
    required this.email,
    required this.appUrl,
  });
}

/// Use case for sending sign-in link to email for passwordless authentication
@lazySingleton
class SendSignInLinkUseCase implements UseCase<void, SendSignInLinkParams> {
  final AuthRepository _authRepository;

  SendSignInLinkUseCase(this._authRepository);

  @override
  Future<Either<Failure, void>> call(SendSignInLinkParams params) async {
    return await _authRepository.sendSignInLinkToEmail(
      email: params.email,
      appUrl: params.appUrl,
    );
  }
}
