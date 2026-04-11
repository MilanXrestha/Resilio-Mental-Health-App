import 'package:injectable/injectable.dart';

import '../datasources/remote/profile_remote_datasource.dart';
import '../../domain/entities/therapist_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

@LazySingleton(as: TherapistProfileRepository)
class ProfileRepositoryImpl implements TherapistProfileRepository {
  final ProfileRemoteDataSource _dataSource;

  ProfileRepositoryImpl(this._dataSource);

  @override
  Future<TherapistProfileEntity> getProfile() async {
    try {
      final map = await _dataSource.getProfile();
      return TherapistProfileEntity.fromMap(map);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      return await _dataSource.updateProfile(data);
    } catch (e) {
      rethrow;
    }
  }
}
