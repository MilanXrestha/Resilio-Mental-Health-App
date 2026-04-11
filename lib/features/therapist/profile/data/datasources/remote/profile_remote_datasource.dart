import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileRemoteDataSource {
  Future<Map<String, dynamic>> getProfile();
  Future<bool> updateProfile(Map<String, dynamic> data);
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _dio.get('/therapist-portal/profile');
      return response.data['profile'] as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch profile: $e');
    }
  }

  @override
  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      await _dio.put('/therapist-portal/profile', data: data);
      return true;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
