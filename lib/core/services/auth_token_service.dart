import 'package:injectable/injectable.dart';

/// Unified token store that works for both Firebase and SuperTokens logins.
///
/// Firebase users  → token is the Firebase ID token (refreshed by FirebaseAuth)
/// SuperTokens users → token is the ST access token from consumeCode response
///
/// Any repository that needs to call an authenticated endpoint should call
/// [getToken()] instead of directly using FirebaseAuth.
@lazySingleton
class AuthTokenService {
  String? _currentToken;

  /// The auth provider that set the current token.
  AuthProvider _provider = AuthProvider.none;

  /// Store a token from any provider. Call this right after sign-in.
  void setToken(String token, {AuthProvider provider = AuthProvider.superTokens}) {
    if (token.isEmpty) {
      throw ArgumentError('Token cannot be empty');
    }
    _currentToken = token;
    _provider = provider;
  }

  /// The active auth token, or null if no user is signed in.
  String? get token => _currentToken;

  /// Which provider supplied the current token.
  AuthProvider get provider => _provider;

  /// Clear on sign-out.
  void clear() {
    _currentToken = null;
    _provider = AuthProvider.none;
  }

  /// Returns true if we have any token stored.
  bool get hasToken => _currentToken != null && _currentToken!.isNotEmpty;
}

enum AuthProvider { none, firebase, superTokens }
