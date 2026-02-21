import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/backend_auth_data_source.dart';
import '../datasources/remote/firebase_auth_data_source.dart';
import '../../../preferences/domain/repositories/preference_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _firebaseAuthDataSource;
  final BackendAuthDataSource _backendDataSource;
  final PreferenceRepository _preferenceRepository;

  AuthRepositoryImpl(
    this._firebaseAuthDataSource,
    this._backendDataSource,
    this._preferenceRepository,
  );

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuthDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Sync user to backend
      await _syncUserToBackend(credential.user!);

      final user = await _getUserEntity(credential.user!);
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
      final credential = await _firebaseAuthDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name if provided
      if (name != null && name.isNotEmpty) {
        await _firebaseAuthDataSource.updateDisplayName(name);
      }

      // Sync user to backend
      await _syncUserToBackend(credential.user!);

      // New user always has preferences as false initially
      final user = await _getUserEntity(credential.user!, forceNotCompleted: true);
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

      // Sync user to backend
      await _syncUserToBackend(credential.user!);

      final user = await _getUserEntity(credential.user!);
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

      // Sync user to backend
      await _syncUserToBackend(credential.user!);

      final user = await _getUserEntity(credential.user!);
      return Right(user);
    } on firebase.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendSignInLinkToEmail({
    required String email,
    required String appUrl,
  }) async {
    try {
      await _firebaseAuthDataSource.sendSignInLinkToEmail(
        email: email,
        appUrl: appUrl,
      );
      return const Right(null);
    } on firebase.FirebaseAuthException catch (e) {
      return Left(_mapFirebaseError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  bool isSignInWithEmailLink(String link) {
    return _firebaseAuthDataSource.isSignInWithEmailLink(link);
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailLink({
    required String email,
    required String link,
  }) async {
    try {
      final credential = await _firebaseAuthDataSource.signInWithEmailLink(
        email: email,
        link: link,
      );

      // Sync user to backend
      await _syncUserToBackend(credential.user!);

      final user = await _getUserEntity(credential.user!);
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
      return const Right(null);
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
      (firebaseUser) async => firebaseUser != null ? await _getUserEntity(firebaseUser) : null,
    );
  }

  /// Sync Firebase user to backend database
  /// This is called after successful Firebase authentication
  Future<void> _syncUserToBackend(firebase.User firebaseUser) async {
    try {
      await _backendDataSource.syncUser(
        firebaseUser: firebaseUser,
      );
    } catch (e) {
      // Log error but don't fail authentication if backend sync fails
      // This ensures users can still log in even if backend is temporarily down
      print('Warning: Failed to sync user to backend: $e');
    }
  }

  Future<UserEntity> _getUserEntity(firebase.User firebaseUser, {bool forceNotCompleted = false}) async {
    bool isCompleted = false;
    if (!forceNotCompleted) {
      final result = await _preferenceRepository.hasCompletedPreferences();
      isCompleted = result.getOrElse(() => false);
    }

    return UserEntity(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? firebaseUser.email?.split('@').first ?? 'User',
      role: 'customer',
      preferencesCompleted: isCompleted,
    );
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
}
