import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class ContentRemoteDataSource {
  Future<Map<String, dynamic>> getContent(String type);
  Future<Map<String, dynamic>> createContent(String type, Map<String, dynamic> data);
  Future<Map<String, dynamic>> updateContent(String type, String id, Map<String, dynamic> data);
  Future<bool> deleteContent(String type, String id);
}

@LazySingleton(as: ContentRemoteDataSource)
class ContentRemoteDataSourceImpl implements ContentRemoteDataSource {
  final Dio _dio;

  ContentRemoteDataSourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getContent(String type) async {
    try {
      final response = await _dio.get('/therapist-portal/content/$type');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch content ($type): $e');
    }
  }

  @override
  Future<Map<String, dynamic>> createContent(String type, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/therapist-portal/content/$type', data: data);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create content ($type): $e');
    }
  }

  @override
  Future<Map<String, dynamic>> updateContent(String type, String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/therapist-portal/content/$type/$id', data: data);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to update content ($type/$id): $e');
    }
  }

  @override
  Future<bool> deleteContent(String type, String id) async {
    try {
      await _dio.delete('/therapist-portal/content/$type/$id');
      return true;
    } catch (e) {
      throw Exception('Failed to delete content ($type/$id): $e');
    }
  }
}
