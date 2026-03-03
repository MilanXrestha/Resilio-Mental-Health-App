import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Verifies the OTP entered by the user and completes passwordless sign-in.
@injectable
class VerifyOtpUseCase implements UseCase<UserEntity, VerifyOtpParams> {
  final AuthRepository _repository;
  const VerifyOtpUseCase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> call(VerifyOtpParams params) =>
      _repository.verifyOtp(
        email: params.email,
        otp: params.otp,
        preAuthSessionId: params.preAuthSessionId,
        deviceId: params.deviceId,
      );
}

class VerifyOtpParams extends Equatable {
  final String email;
  final String otp;
  final String preAuthSessionId;
  final String deviceId;

  const VerifyOtpParams({
    required this.email,
    required this.otp,
    required this.preAuthSessionId,
    required this.deviceId,
  });

  @override
  List<Object?> get props => [email, otp, preAuthSessionId, deviceId];
}
