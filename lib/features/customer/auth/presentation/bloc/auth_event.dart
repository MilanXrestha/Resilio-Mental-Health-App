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

class SendSignInLinkRequested extends AuthEvent {
  final String email;
  final String appUrl;

  const SendSignInLinkRequested({
    required this.email,
    required this.appUrl,
  });

  @override
  List<Object?> get props => [email, appUrl];
}

class SignInWithEmailLinkRequested extends AuthEvent {
  final String email;
  final String link;

  const SignInWithEmailLinkRequested({
    required this.email,
    required this.link,
  });

  @override
  List<Object?> get props => [email, link];
}

class LogoutRequested extends AuthEvent {}

// Alias for LogoutRequested (used in some screens)
class SignOutRequested extends AuthEvent {}
