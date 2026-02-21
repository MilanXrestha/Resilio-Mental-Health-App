import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    String? name,
  });

  /// Sign in with Google
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  /// Sign in with Facebook
  Future<Either<Failure, UserEntity>> signInWithFacebook();

  /// Send sign-in link to email for passwordless authentication
  Future<Either<Failure, void>> sendSignInLinkToEmail({
    required String email,
    required String appUrl,
  });

  /// Check if the incoming link is a valid email sign-in link
  bool isSignInWithEmailLink(String link);

  /// Sign in with email link (passwordless)
  Future<Either<Failure, UserEntity>> signInWithEmailLink({
    required String email,
    required String link,
  });

  /// Sign out
  Future<Either<Failure, void>> logout();

  /// Get current cached user
  Future<Either<Failure, UserEntity?>> getCachedUser();

  /// Get auth state stream
  Stream<UserEntity?> get authStateChanges;
}
