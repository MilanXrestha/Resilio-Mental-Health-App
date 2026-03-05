import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  
  SharedPreferences? _prefs;

  static const _keyToken = 'auth_token';
  static const _keyProvider = 'auth_provider';
  static const _keyUserId = 'auth_user_id';

  /// Initialize - load token from storage and refresh if needed
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    // Load saved token from storage
    _currentToken = _prefs?.getString(_keyToken);
    final providerStr = _prefs?.getString(_keyProvider);
    _userId = _prefs?.getString(_keyUserId);
    
    // Restore provider
    if (providerStr == 'firebase') {
      _provider = AuthProvider.firebase;
      
      // For Firebase users, check if we need to refresh the token
      if (_currentToken != null && FirebaseAuth.instance.currentUser != null) {
        try {
          // Get a fresh ID token from Firebase
          final freshToken = await FirebaseAuth.instance.currentUser!.getIdToken();
          if (freshToken != null && freshToken.isNotEmpty) {
            _currentToken = freshToken;
            // Update storage with fresh token
            await _prefs?.setString(_keyToken, freshToken);
            print('✓ AuthTokenService: Refreshed Firebase ID token');
          }
        } catch (e) {
          print('⚠️ AuthTokenService: Failed to refresh token: $e');
          // If refresh fails, clear the token as it's definitely expired
          await clear();
          return;
        }
      }
    } else if (providerStr == 'supertokens') {
      _provider = AuthProvider.superTokens;
    } else {
      _provider = AuthProvider.none;
      // No valid provider, clear any stale data
      if (_currentToken != null) {
        await clear();
      }
    }
    
    if (_currentToken != null) {
      print('✓ AuthTokenService: Loaded token from storage, provider: $_provider');
    }
  }

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
    
    // Persist to storage
    _prefs?.setString(_keyToken, token);
    _prefs?.setString(_keyProvider, provider.name);
    if (userId != null) {
      _prefs?.setString(_keyUserId, userId);
    }
    
    print('✓ AuthTokenService: Token stored, provider: $provider, userId: $userId');
  }

  /// Set user ID separately (useful when ID comes from a different source)
  void setUserId(String userId) {
    _userId = userId;
    _prefs?.setString(_keyUserId, userId);
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
  Future<void> clear() async {
    _currentToken = null;
    _userId = null;
    _provider = AuthProvider.none;
    // Clear from storage
    await _prefs?.remove(_keyToken);
    await _prefs?.remove(_keyProvider);
    await _prefs?.remove(_keyUserId);
    print('✓ AuthTokenService: Cleared all tokens');
  }
}

enum AuthProvider { none, firebase, superTokens }
