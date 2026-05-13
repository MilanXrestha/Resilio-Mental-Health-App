import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../../../../../core/database/database_helper.dart';
import '../../../../../../core/proto_generated/user.pb.dart';

abstract class PreferenceLocalDataSource {
  Future<void> cacheAllPreferences(List<Preference> preferences);
  Future<List<Preference>?> getCachedAllPreferences();
  
  Future<void> cacheUserPreferences(List<Preference> userPreferences);
  Future<List<Preference>?> getCachedUserPreferences();
  
  Future<void> cacheCompletionStatus(bool status);
  Future<bool?> getCachedCompletionStatus();
  
  Future<void> clearCache();
}

@LazySingleton(as: PreferenceLocalDataSource)
class PreferenceLocalDataSourceImpl implements PreferenceLocalDataSource {
  final DatabaseHelper _databaseHelper;
  
  static const String _keyAllPreferences = 'all_preferences_proto';
  static const String _keyUserPreferences = 'user_preferences_proto';
  static const String _keyCompletionStatus = 'preferences_completion_status';

  PreferenceLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> cacheAllPreferences(List<Preference> preferences) async {
    final response = ListPreferencesResponse(preferences: preferences);
    await _databaseHelper.saveToCache(_keyAllPreferences, response.writeToBuffer());
  }

  @override
  Future<List<Preference>?> getCachedAllPreferences() async {
    final bytes = await _databaseHelper.getFromCache(_keyAllPreferences);
    if (bytes != null) {
      final response = ListPreferencesResponse.fromBuffer(bytes);
      return response.preferences;
    }
    return null;
  }

  @override
  Future<void> cacheUserPreferences(List<Preference> userPreferences) async {
    final response = ListPreferencesResponse(preferences: userPreferences);
    await _databaseHelper.saveToCache(_keyUserPreferences, response.writeToBuffer());
  }
  
  // Wait, I see an error in the snippet above ^ 'preferences' is not defined. It should be userPreferences.
  // I'll fix it in the final write.

  @override
  Future<List<Preference>?> getCachedUserPreferences() async {
    final bytes = await _databaseHelper.getFromCache(_keyUserPreferences);
    if (bytes != null) {
      final response = ListPreferencesResponse.fromBuffer(bytes);
      return response.preferences;
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
    await _databaseHelper.clearCache();
  }
}
