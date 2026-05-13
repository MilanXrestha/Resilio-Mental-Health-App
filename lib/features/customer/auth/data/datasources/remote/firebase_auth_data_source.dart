import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'dart:io' show Platform;

/// Data source for Firebase Authentication operations
@LazySingleton()
class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  bool _isInitialized = false;

  FirebaseAuthDataSource(
    this._firebaseAuth,
    this._googleSignIn,
    this._facebookAuth,
  );

  /// Initialize Google Sign In - must be called before any other methods
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await _googleSignIn.initialize();
      _isInitialized = true;
    }
  }

  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Initialize Google Sign In first (required in v7.x)
      await _ensureInitialized();
      
      // Check if the platform supports authenticate() method
      if (_googleSignIn.supportsAuthenticate()) {
        // Use the new authenticate() method for web and mobile
        final googleUser = await _googleSignIn.authenticate();
        final googleAuth = googleUser.authentication;
        
        // Create a new credential - only idToken is needed for Firebase
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        
        // Sign in to Firebase with the Google credential
        return await _firebaseAuth.signInWithCredential(credential);
      } else {
        // Fallback for platforms that don't support authenticate()
        final googleProvider = GoogleAuthProvider();
        return await _firebaseAuth.signInWithProvider(googleProvider);
      }
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        // User cancelled the sign-in
        return null;
      }
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  /// Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Auth state changes stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Update user display name
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
    }
  }

  /// Sign in with Facebook
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Prefer Firebase managed OAuth flow on mobile.
      // This avoids Android native-Facebook package visibility edge cases.
      final facebookProvider = FacebookAuthProvider();
      return await _firebaseAuth.signInWithProvider(facebookProvider);
    } on FirebaseAuthException catch (e) {
      // If provider flow fails for setup/runtime reasons, fall back to token-based flow.
      if (e.code != 'operation-not-allowed') {
        return await _signInWithFacebookTokenFlow();
      }
      rethrow;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'facebook-login-error',
        message: e.toString(),
      );
    }
  }

  /// Legacy token-based Facebook login flow
  Future<UserCredential?> _signInWithFacebookTokenFlow() async {
    try {
      // Ensure stale sessions do not affect a new login attempt.
      await _facebookAuth.logOut();

      // Trigger the Facebook login flow
      final LoginResult loginResult = await _facebookAuth.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: Platform.isAndroid
            ? LoginBehavior.nativeWithFallback
            : LoginBehavior.dialogOnly,
      );

      // If not successful (cancelled or failed), handle accordingly
      if (loginResult.status != LoginStatus.success) {
        if (loginResult.status == LoginStatus.cancelled) {
          // User cancelled the login
          return null;
        }
        // Login failed
        throw FirebaseAuthException(
          code: 'facebook-login-failed',
          message:
              'Facebook login failed (${loginResult.status.name}): ${loginResult.message ?? 'Unknown Facebook error'}',
        );
      }

      // Get the access token
      final AccessToken? accessToken = loginResult.accessToken;
      if (accessToken == null) {
        throw FirebaseAuthException(
          code: 'facebook-login-failed',
          message: 'Failed to get Facebook access token',
        );
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.tokenString);

      // Sign in to Firebase with the Facebook credential
      return await _firebaseAuth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'facebook-login-error',
        message: e.toString(),
      );
    }
  }

}
