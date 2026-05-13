import 'dart:convert';
import 'package:Resilio/features/customer/dashboard/domain/entities/user_profile_entity.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/database/database_helper.dart';

abstract class DashboardLocalDataSource {
  Future<void> cacheUserProfile(UserProfile profile);
  Future<UserProfile?> getCachedUserProfile();
  Future<void> clearCache();
}

@LazySingleton(as: DashboardLocalDataSource)
class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final DatabaseHelper _databaseHelper;
  static const String _keyUserProfile = 'dashboard_user_profile';

  DashboardLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> cacheUserProfile(UserProfile profile) async {
    final data = jsonEncode({
      'uid': profile.uid,
      'firstName': profile.firstName,
      'lastName': profile.lastName,
      'email': profile.email,
      'profilePictureUrl': profile.profilePictureUrl,
    });
    await _databaseHelper.saveToCache(_keyUserProfile, utf8.encode(data));
  }

  @override
  Future<UserProfile?> getCachedUserProfile() async {
    final bytes = await _databaseHelper.getFromCache(_keyUserProfile);
    if (bytes != null) {
      final data = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
      return UserProfile(
        uid: data['uid'] ?? '',
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        profilePictureUrl: data['profilePictureUrl'],
      );
    }
    return null;
  }

  @override
  Future<void> clearCache() async {
    await _databaseHelper.clearCache();
  }
}
