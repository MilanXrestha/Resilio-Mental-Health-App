import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

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

class SignInLinkSent extends AuthState {
  const SignInLinkSent();
}
