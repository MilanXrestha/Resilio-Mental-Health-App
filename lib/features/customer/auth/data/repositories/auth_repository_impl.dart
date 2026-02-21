import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/firebase_auth_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _firebaseAuthDataSource;

  AuthRepositoryImpl(this._firebaseAuthDataSource);

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

      final user = _mapFirebaseUserToEntity(credential.user!);
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

      final user = _mapFirebaseUserToEntity(credential.user!);
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

      final user = _mapFirebaseUserToEntity(credential.user!);
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

      final user = _mapFirebaseUserToEntity(credential.user!);
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

      final user = _mapFirebaseUserToEntity(credential.user!);
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
        return Right(_mapFirebaseUserToEntity(user));
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuthDataSource.authStateChanges.map(
      (firebaseUser) => firebaseUser != null ? _mapFirebaseUserToEntity(firebaseUser) : null,
    );
  }

  UserEntity _mapFirebaseUserToEntity(firebase.User firebaseUser) {
    return UserEntity(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? firebaseUser.email?.split('@').first ?? 'User',
      role: 'customer',
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
