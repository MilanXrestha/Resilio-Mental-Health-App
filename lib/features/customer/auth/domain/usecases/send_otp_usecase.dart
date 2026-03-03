import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

/// Sends a one-time password to the given email via SuperTokens passwordless.
/// Returns the [preAuthSessionId] + [deviceId] needed for OTP verification.
@injectable
class SendOtpUseCase implements UseCase<OtpSessionData, SendOtpParams> {
  final AuthRepository _repository;
  const SendOtpUseCase(this._repository);

  @override
  Future<Either<Failure, OtpSessionData>> call(SendOtpParams params) =>
      _repository.sendOtp(email: params.email);
}

class SendOtpParams extends Equatable {
  final String email;
  const SendOtpParams({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Holds the session context returned by SuperTokens after sending the OTP.
/// Both fields are required to consume (verify) the OTP later.
class OtpSessionData extends Equatable {
  final String preAuthSessionId;
  final String deviceId;

  const OtpSessionData({
    required this.preAuthSessionId,
    required this.deviceId,
  });

  @override
  List<Object?> get props => [preAuthSessionId, deviceId];
}
