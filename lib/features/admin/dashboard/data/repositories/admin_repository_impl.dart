import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/admin/dashboard/domain/repositories/admin_repository.dart';

@LazySingleton(as: AdminRepository)
class AdminRepositoryImpl implements AdminRepository {
  final Dio _dio;

  AdminRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await _dio.get('/admin/stats');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load admin stats: $e');
    }
  }

  @override
  Future<List<dynamic>> getUsers() async {
    try {
      final response = await _dio.get('/users');
      return response.data['users'] as List<dynamic>? ?? [];
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  @override
  Future<List<dynamic>> getTherapists({bool verified = true}) async {
    try {
      // In a real scenario we'd pass query parms, but our endpoint lists all
      // Let's assume we filter on client if backend doesnt support `?verified=false` yet.
      // Our list profiles API doesn't have is_verified filter exposed directly right now, 
      // but it might return it in payload.
      final response = await _dio.get('/therapists');
      final list = response.data['therapists'] as List<dynamic>? ?? [];
      
      return list.where((th) => (th['isVerified'] ?? false) == verified).toList();
    } catch (e) {
      throw Exception('Failed to load therapists: $e');
    }
  }

  @override
  Future<bool> verifyTherapist(String therapistId, {required bool approve}) async {
    try {
      await _dio.patch('/therapists/$therapistId', data: {
        'isVerified': approve,
      });
      return true;
    } catch (e) {
      throw Exception('Failed to update therapist: $e');
    }
  }
}
