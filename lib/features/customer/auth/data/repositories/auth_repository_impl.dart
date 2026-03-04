import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/services/auth_token_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../datasources/remote/backend_auth_data_source.dart';
import '../datasources/remote/firebase_auth_data_source.dart';
import '../datasources/remote/supertokens_data_source.dart';
import '../../../preferences/domain/repositories/preference_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _firebaseAuthDataSource;
  final BackendAuthDataSource _backendDataSource;
  final PreferenceRepository _preferenceRepository;
  final SuperTokensDataSource _superTokensDataSource;
  final AuthTokenService _authTokenService;

  AuthRepositoryImpl(
      this._firebaseAuthDataSource,
      this._backendDataSource,
      this._preferenceRepository,
      this._superTokensDataSource,
      this._authTokenService,
      );

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuthDataSource
          .signInWithEmailAndPassword(email: email, password: password);

      // Store Firebase token so preferences and other protected routes work
      final idToken = await credential.user?.getIdToken();
      if (idToken != null) {
        _authTokenService.setToken(
          idToken,
          provider: AuthProvider.firebase,
          userId: credential.user!.uid,
        );
      }

      // Sync user to backend
      final syncedUser = await _syncUserToBackend(credential.user!);

      final user = syncedUser ?? await _getUserEntity(credential.user!);
      return Right(user);
    } on firebase.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final credential = await _firebaseAuthDataSource
          .signUpWithEmailAndPassword(email: email, password: password);

      // Update display name if provided
      if (name != null && name.isNotEmpty) {
        await _firebaseAuthDataSource.updateDisplayName(name);
      }

      // Store Firebase token
      final idToken = await credential.user?.getIdToken();
      if (idToken != null) {
        _authTokenService.setToken(
          idToken,
          provider: AuthProvider.firebase,
          userId: credential.user!.uid,
        );
      }

      // Sync user to backend
      final syncedUser = await _syncUserToBackend(credential.user!);

      final user =
          syncedUser ??
              await _getUserEntity(credential.user!, forceNotCompleted: true);
      return Right(user);
    } on firebase.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final credential = await _firebaseAuthDataSource.signInWithGoogle();

      if (credential == null) {
        return const Left(ServerFailure('Google sign in cancelled'));
      }

      // Store Firebase token
      final idToken = await credential.user?.getIdToken();
      if (idToken != null) {
        _authTokenService.setToken(
          idToken,
          provider: AuthProvider.firebase,
          userId: credential.user!.uid,
        );
      }

      // Sync user to backend
      final syncedUser = await _syncUserToBackend(credential.user!);

      final user = syncedUser ?? await _getUserEntity(credential.user!);
      return Right(user);
    } on firebase.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    try {
      final credential = await _firebaseAuthDataSource.signInWithFacebook();

      if (credential == null) {
        return const Left(ServerFailure('Facebook sign in cancelled'));
      }

      // Store Firebase token
      final idToken = await credential.user?.getIdToken();
      if (idToken != null) {
        _authTokenService.setToken(
          idToken,
          provider: AuthProvider.firebase,
          userId: credential.user!.uid,
        );
      }

      // Sync user to backend
      final syncedUser = await _syncUserToBackend(credential.user!);

      final user = syncedUser ?? await _getUserEntity(credential.user!);
      return Right(user);
    } on firebase.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _preferenceRepository.clearLocalData();
      await _firebaseAuthDataSource.signOut();
      _authTokenService.clear();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ─── SuperTokens Passwordless ───────────────────────────────────────────────

  @override
  Future<Either<Failure, OtpSessionData>> sendOtp({
    required String email,
  }) async {
    try {
      final session = await _superTokensDataSource.createCode(email: email);
      return Right(session);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp({
    required String email,
    required String otp,
    required String preAuthSessionId,
    required String deviceId,
  }) async {
    try {
      // Step 1: verify OTP with SuperTokens — response contains the access token
      final consumeResult = await _superTokensDataSource.consumeCode(
        preAuthSessionId: preAuthSessionId,
        deviceId: deviceId,
        userInputCode: otp,
      );

      // Extract SuperTokens access token from response
      String? accessToken;

      final rawAccessToken = consumeResult['accessToken'];
      if (rawAccessToken != null) {
        if (rawAccessToken is Map<String, dynamic>) {
          accessToken = rawAccessToken['token'] as String?;
        } else if (rawAccessToken is String) {
          accessToken = rawAccessToken;
        }
      }

      // Fallback: check session object if accessToken not found
      if (accessToken == null || accessToken.isEmpty) {
        final session = consumeResult['session'] as Map<String, dynamic>?;
        if (session != null) {
          accessToken =
              session['accessToken'] as String? ?? (session['token'] as String?);
        }
      }

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception(
            'Failed to extract access token from SuperTokens response');
      }

      // Store token with provider info (userId will be set after backend sync)
      _authTokenService.setToken(
        accessToken,
        provider: AuthProvider.superTokens,
      );

      // Step 2: sync user into our Supabase DB
      try {
        final backendData =
        await _superTokensDataSource.completePasswordlessLogin(
          email: email,
          accessToken: accessToken,
        );
        final u = backendData['user'] as Map<String, dynamic>?;
        if (u != null) {
          final userId = u['id'] as String? ?? email;

          // Store user ID in auth service
          _authTokenService.setUserId(userId);

          return Right(UserEntity(
            id: userId,
            email: u['email'] as String? ?? email,
            name: (u['display_name'] as String?)?.isNotEmpty == true
                ? u['display_name'] as String
                : email.split('@').first,
            role: u['user_role'] as String? ?? 'customer',
            preferencesCompleted: (u['preferences_completed'] as bool?) ?? false,
          ));
        }
      } catch (e) {
        // Backend sync failed — return minimal entity so login still succeeds
        print('Backend sync failed: $e');
      }

      // Store email as user ID fallback
      _authTokenService.setUserId(email);

      return Right(UserEntity(
        id: email,
        email: email,
        name: email.split('@').first,
        role: 'customer',
        preferencesCompleted: false,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCachedUser() async {
    try {
      final user = _firebaseAuthDataSource.currentUser;
      if (user != null) {
        return Right(await _getUserEntity(user));
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuthDataSource.authStateChanges.asyncMap(
          (firebaseUser) async =>
      firebaseUser != null ? await _getUserEntity(firebaseUser) : null,
    );
  }

  /// Sync Firebase user to backend database
  /// Returns UserEntity from backend
  Future<UserEntity?> _syncUserToBackend(firebase.User firebaseUser) async {
    try {
      final backendUser = await _backendDataSource.syncUser(
        firebaseUser: firebaseUser,
      );

      // Update userId in auth service
      _authTokenService.setUserId(backendUser.id);

      return UserEntity(
        id: backendUser.id,
        email: backendUser.email,
        name: backendUser.displayName.isNotEmpty
            ? backendUser.displayName
            : (backendUser.username.isNotEmpty ? backendUser.username : 'User'),
        role: backendUser.userRole.isNotEmpty
            ? backendUser.userRole
            : 'customer',
        preferencesCompleted: backendUser.preferencesCompleted,
      );
    } catch (e) {
      print('Warning: Failed to sync user to backend: $e');
      return null;
    }
  }

  Future<UserEntity> _getUserEntity(
      firebase.User firebaseUser, {
        bool forceNotCompleted = false,
      }) async {
    bool isCompleted = false;
    if (!forceNotCompleted) {
      final result = await _preferenceRepository.hasCompletedPreferences();
      isCompleted = result.getOrElse(() => false);
    }

    return UserEntity(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ??
          firebaseUser.email?.split('@').first ??
          'User',
      role: 'customer',
      preferencesCompleted: isCompleted,
    );
  }
}

Failure _mapFirebaseError(firebase.FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return const ServerFailure('No user found with this email');
    case 'wrong-password':
      return const ServerFailure('Incorrect password');
    case 'invalid-email':
      return const ServerFailure('Invalid email address');
    case 'user-disabled':
      return const ServerFailure('This account has been disabled');
    case 'email-already-in-use':
      return const ServerFailure('An account already exists with this email');
    case 'weak-password':
      return const ServerFailure('Password is too weak');
    case 'invalid-credential':
      return const ServerFailure('Invalid credentials');
    case 'account-exists-with-different-credential':
      return const ServerFailure(
        'An account already exists with this email using a different sign-in method',
      );
    case 'operation-not-allowed':
      return const ServerFailure(
        'Facebook sign-in is not enabled in Firebase Authentication',
      );
    default:
      return ServerFailure(e.message ?? 'Authentication failed');
  }
}