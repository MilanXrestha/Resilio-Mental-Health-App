import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../../domain/usecases/send_otp_usecase.dart';

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
    String userRole = 'customer',
  });

  /// Sign in with Google
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  /// Sign in with Facebook
  Future<Either<Failure, UserEntity>> signInWithFacebook();

  /// Send OTP to email (SuperTokens passwordless)
  Future<Either<Failure, OtpSessionData>> sendOtp({required String email});

  /// Verify OTP and sign in (SuperTokens passwordless)
  /// [preAuthSessionId] and [deviceId] are returned from sendOtp.
  Future<Either<Failure, UserEntity>> verifyOtp({
    required String email,
    required String otp,
    required String preAuthSessionId,
    required String deviceId,
  });

  /// Sign out
  Future<Either<Failure, void>> logout();

  /// Get current cached user
  Future<Either<Failure, UserEntity?>> getCachedUser();

  /// Get auth state stream
  Stream<UserEntity?> get authStateChanges;
}
