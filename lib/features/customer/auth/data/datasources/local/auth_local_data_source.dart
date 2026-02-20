import 'package:injectable/injectable.dart';
import 'package:resilio/core/database/database_helper.dart';
import 'package:resilio/core/proto_generated/auth.pb.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(User user);
  Future<User?> getCachedUser();
  Future<void> clearCache();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseHelper _databaseHelper;
  static const String _userCacheKey = 'customer_user';

  AuthLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> cacheUser(User user) async {
    await _databaseHelper.saveToCache(_userCacheKey, user.writeToBuffer());
  }

  @override
  Future<User?> getCachedUser() async {
    final data = await _databaseHelper.getFromCache(_userCacheKey);
    if (data != null) {
      return User.fromBuffer(data);
    }
    return null;
  }

  @override
  Future<void> clearCache() async {
    await _databaseHelper.clearCache();
  }
}
