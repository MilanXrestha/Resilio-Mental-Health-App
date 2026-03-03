import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/send_otp_usecase.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;
  final bool isNewUser;
  
  const AuthAuthenticated(this.user, {this.isNewUser = false});

  @override
  List<Object?> get props => [user, isNewUser];
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Emitted after a successful OTP send — carries context for the verify step.
class OtpSent extends AuthState {
  final String email;
  final OtpSessionData sessionData;

  const OtpSent({required this.email, required this.sessionData});

  @override
  List<Object?> get props => [email, sessionData];
}
