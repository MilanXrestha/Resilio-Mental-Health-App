import 'package:injectable/injectable.dart';

/// Unified token store that works for both Firebase and SuperTokens logins.
///
/// Firebase users  → token is the Firebase ID token (refreshed by FirebaseAuth)
/// SuperTokens users → token is the ST access token from consumeCode response
///
/// Any repository that needs to call an authenticated endpoint should call
/// [token] instead of directly using FirebaseAuth.
@lazySingleton
class AuthTokenService {
  String? _currentToken;
  String? _userId;

  /// The auth provider that set the current token.
  AuthProvider _provider = AuthProvider.none;

  /// Store a token from any provider. Call this right after sign-in.
  void setToken(
    String token, {
    AuthProvider provider = AuthProvider.superTokens,
    String? userId,
  }) {
    if (token.isEmpty) {
      throw ArgumentError('Token cannot be empty');
    }
    _currentToken = token;
    _provider = provider;
    if (userId != null) {
      _userId = userId;
    }
  }

  /// Set user ID separately (useful when ID comes from a different source)
  void setUserId(String userId) {
    _userId = userId;
  }

  /// The active auth token, or null if no user is signed in.
  String? get token => _currentToken;

  /// The current user ID
  String? get userId => _userId;

  /// Which provider supplied the current token.
  AuthProvider get provider => _provider;

  /// Returns true if we have any token stored.
  bool get hasToken => _currentToken != null && _currentToken!.isNotEmpty;

  /// Check if user is authenticated
  bool get isAuthenticated => hasToken;

  /// Check if using Firebase auth
  bool get isFirebaseAuth => _provider == AuthProvider.firebase;

  /// Check if using SuperTokens auth
  bool get isSuperTokensAuth => _provider == AuthProvider.superTokens;

  /// Clear on sign-out.
  void clear() {
    _currentToken = null;
    _userId = null;
    _provider = AuthProvider.none;
  }
}

enum AuthProvider { none, firebase, superTokens }
