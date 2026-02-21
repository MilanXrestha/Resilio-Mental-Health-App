import 'dart:convert';
import 'package:injectable/injectable.dart';

import '../../../../../../core/database/database_helper.dart';

abstract class PreferenceLocalDataSource {
  Future<void> cacheAllPreferences(List<Map<String, dynamic>> preferences);
  Future<List<Map<String, dynamic>>?> getCachedAllPreferences();
  
  Future<void> cacheUserPreferences(List<Map<String, dynamic>> userPreferences);
  Future<List<Map<String, dynamic>>?> getCachedUserPreferences();
  
  Future<void> cacheCompletionStatus(bool status);
  Future<bool?> getCachedCompletionStatus();
  
  Future<void> clearCache();
}

@LazySingleton(as: PreferenceLocalDataSource)
class PreferenceLocalDataSourceImpl implements PreferenceLocalDataSource {
  final DatabaseHelper _databaseHelper;
  
  static const String _keyAllPreferences = 'all_preferences';
  static const String _keyUserPreferences = 'user_preferences';
  static const String _keyCompletionStatus = 'preferences_completion_status';

  PreferenceLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> cacheAllPreferences(List<Map<String, dynamic>> preferences) async {
    final bytes = utf8.encode(jsonEncode(preferences));
    await _databaseHelper.saveToCache(_keyAllPreferences, bytes);
  }

  @override
  Future<List<Map<String, dynamic>>?> getCachedAllPreferences() async {
    final bytes = await _databaseHelper.getFromCache(_keyAllPreferences);
    if (bytes != null) {
      final jsonString = utf8.decode(bytes);
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.cast<Map<String, dynamic>>();
    }
    return null;
  }

  @override
  Future<void> cacheUserPreferences(List<Map<String, dynamic>> userPreferences) async {
    final bytes = utf8.encode(jsonEncode(userPreferences));
    await _databaseHelper.saveToCache(_keyUserPreferences, bytes);
  }

  @override
  Future<List<Map<String, dynamic>>?> getCachedUserPreferences() async {
    final bytes = await _databaseHelper.getFromCache(_keyUserPreferences);
    if (bytes != null) {
      final jsonString = utf8.decode(bytes);
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.cast<Map<String, dynamic>>();
    }
    return null;
  }

  @override
  Future<void> cacheCompletionStatus(bool status) async {
    final bytes = utf8.encode(jsonEncode(status));
    await _databaseHelper.saveToCache(_keyCompletionStatus, bytes);
  }

  @override
  Future<bool?> getCachedCompletionStatus() async {
    final bytes = await _databaseHelper.getFromCache(_keyCompletionStatus);
    if (bytes != null) {
      final jsonString = utf8.decode(bytes);
      return jsonDecode(jsonString) as bool;
    }
    return null;
  }

  @override
  Future<void> clearCache() async {
    // Note: DatabaseHelper.clearCache() clears the entire cache table.
    // If we want to only clear preference-specific keys, we'd need a more granular clear method.
    // However, following the pattern in AuthLocalDataSourceImpl:
    await _databaseHelper.clearCache();
  }
}
