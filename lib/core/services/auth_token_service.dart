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
      
      // For Firebase users, try to get a fresh token.
      // currentUser may be null here if Firebase hasn't finished restoring its
      // session yet — in that case keep whatever was loaded from SharedPreferences
      // and let ensureAuthenticated() handle the refresh on first use.
      final fbUser = FirebaseAuth.instance.currentUser;
      if (fbUser != null) {
        try {
          final freshToken = await fbUser.getIdToken();
          if (freshToken != null && freshToken.isNotEmpty) {
            _currentToken = freshToken;
            _userId = fbUser.uid;
            await _prefs?.setString(_keyToken, freshToken);
            await _prefs?.setString(_keyUserId, fbUser.uid);
            print('✓ AuthTokenService: Refreshed Firebase ID token');
          }
        } catch (e) {
          print('⚠️ AuthTokenService: Failed to refresh token: $e');
          // Keep the stored token; it may still be valid.
        }
      }
      // If currentUser is null and _currentToken is also null, the user is
      // genuinely signed out — isAuthenticated will return false as expected.
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

  /// Ensures a valid token is available.
  /// Always tries Firebase as a fallback — handles hot-restart (where init()
  /// was never called) and timing gaps between app start and session restore.
  Future<bool> ensureAuthenticated() async {
    if (hasToken) return true;
    final fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser != null) {
      try {
        final token = await fbUser.getIdToken();
        if (token != null && token.isNotEmpty) {
          _prefs ??= await SharedPreferences.getInstance();
          _provider = AuthProvider.firebase;
          _currentToken = token;
          _userId = fbUser.uid;
          _prefs?.setString(_keyToken, token);
          _prefs?.setString(_keyProvider, 'firebase');
          _prefs?.setString(_keyUserId, fbUser.uid);
          print('✓ AuthTokenService: Token recovered via ensureAuthenticated');
          return true;
        }
      } catch (e) {
        print('⚠️ AuthTokenService: ensureAuthenticated failed: $e');
      }
    }
    return false;
  }

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
