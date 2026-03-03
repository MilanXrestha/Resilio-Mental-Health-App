import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String? name;

  const SignUpRequested({
    required this.email,
    required this.password,
    this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}

class GoogleSignInRequested extends AuthEvent {}

class FacebookSignInRequested extends AuthEvent {}


class LogoutRequested extends AuthEvent {}

// Alias for LogoutRequested (used in some screens)
class SignOutRequested extends AuthEvent {}

/// Passwordless OTP: Step 1 — send OTP code to [email]
class SendOtpRequested extends AuthEvent {
  final String email;
  const SendOtpRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

/// Passwordless OTP: Step 2 — verify the code the user typed
class VerifyOtpRequested extends AuthEvent {
  final String email;
  final String otp;
  final String preAuthSessionId;
  final String deviceId;

  const VerifyOtpRequested({
    required this.email,
    required this.otp,
    required this.preAuthSessionId,
    required this.deviceId,
  });

  @override
  List<Object?> get props => [email, otp, preAuthSessionId, deviceId];
}
