import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service to handle email link authentication
@lazySingleton
class EmailLinkHandler {
  final FirebaseAuth _firebaseAuth;
  final SharedPreferences _prefs;

  EmailLinkHandler(
    this._firebaseAuth,
    this._prefs,
  );

  static const String _pendingEmailKey = 'pending_email_link';

  /// Check if a URL is an email sign-in link
  bool isSignInWithEmailLink(String link) {
    return _firebaseAuth.isSignInWithEmailLink(link);
  }

  /// Save the email locally to complete sign-in later
  Future<void> savePendingEmail(String email) async {
    await _prefs.setString(_pendingEmailKey, email);
  }

  /// Get the saved pending email
  String? getPendingEmail() {
    return _prefs.getString(_pendingEmailKey);
  }

  /// Clear the saved pending email
  Future<void> clearPendingEmail() async {
    await _prefs.remove(_pendingEmailKey);
  }

  /// Complete sign-in with email link
  Future<UserCredential?> completeSignInWithEmailLink(String link) async {
    final email = getPendingEmail();
    if (email == null) {
      throw Exception('No pending email found. Please request a new sign-in link.');
    }

    if (!isSignInWithEmailLink(link)) {
      throw Exception('Invalid email sign-in link.');
    }

    try {
      final result = await _firebaseAuth.signInWithEmailLink(
        email: email,
        emailLink: link,
      );
      await clearPendingEmail();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// Handle incoming link from app launch or deep link
  Future<UserCredential?> handleIncomingLink(String? link) async {
    if (link == null || link.isEmpty) return null;
    
    if (isSignInWithEmailLink(link)) {
      return await completeSignInWithEmailLink(link);
    }
    
    return null;
  }
}
