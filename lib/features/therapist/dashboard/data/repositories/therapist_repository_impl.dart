import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/therapist_repository.dart';

@LazySingleton(as: TherapistRepository)
class TherapistRepositoryImpl implements TherapistRepository {
  final Dio _dio;

  TherapistRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await _dio.get('/therapist-portal/dashboard');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load dashboard: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAppointments({String? status, String? date}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (status != null) queryParams['status'] = status;
      if (date != null) queryParams['date'] = date;
      final response = await _dio.get('/therapist-portal/appointments', queryParameters: queryParams);
      final list = response.data['appointments'] as List<dynamic>? ?? [];
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> updateAppointmentStatus(String appointmentId, String status) async {
    try {
      await _dio.patch(
        '/therapist-portal/appointments/$appointmentId/status',
        data: {'status': status},
      );
      return true;
    } catch (e) {
      throw Exception('Failed to update appointment: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getPatients() async {
    try {
      final response = await _dio.get('/therapist-portal/patients');
      final list = response.data['patients'] as List<dynamic>? ?? [];
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> getEarnings() async {
    try {
      final response = await _dio.get('/therapist-portal/earnings');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      return {
        'totalEarnings': 0,
        'weekEarnings': 0,
        'monthEarnings': 0,
        'weeklyChart': [],
        'transactions': [],
      };
    }
  }

  @override
  Future<Map<String, dynamic>> getPortalProfile() async {
    try {
      final response = await _dio.get('/therapist-portal/profile');
      return response.data['profile'] as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  @override
  Future<bool> updatePortalProfile(Map<String, dynamic> data) async {
    try {
      await _dio.put('/therapist-portal/profile', data: data);
      return true;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<bool> notifyCall(String appointmentId) async {
    try {
      await _dio.post('/therapist-portal/call/notify', data: {'appointmentId': appointmentId});
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getContent(String type) async {
    try {
      final response = await _dio.get('/therapist-portal/content/$type');
      if (type == 'tips') {
        final list = response.data['tips'] as List<dynamic>? ?? [];
        return list.cast<Map<String, dynamic>>();
      } else if (type == 'quotes') {
        final list = response.data['quotes'] as List<dynamic>? ?? [];
        return list.cast<Map<String, dynamic>>();
      } else if (type == 'videos') {
        final list = response.data['videos'] as List<dynamic>? ?? [];
        return list.cast<Map<String, dynamic>>();
      } else if (type == 'audio') {
        final list = response.data['tracks'] as List<dynamic>? ?? [];
        return list.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> createContent(String type, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/therapist-portal/content/$type', data: data);
      // Backend returns { tip: {...} } or { quote: {...} } or { video: {...} }
      final key = type == 'audio' ? 'audio' : type.substring(0, type.length - 1);
      return response.data[key] as Map<String, dynamic>? ?? response.data;
    } catch (e) {
      throw Exception('Failed to create $type: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> updateContent(String type, String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/therapist-portal/content/$type/$id', data: data);
      final key = type == 'audio' ? 'audio' : type.substring(0, type.length - 1);
      return response.data[key] as Map<String, dynamic>? ?? response.data;
    } catch (e) {
      throw Exception('Failed to update $type: $e');
    }
  }

  @override
  Future<bool> deleteContent(String type, String id) async {
    try {
      await _dio.delete('/therapist-portal/content/$type/$id');
      return true;
    } catch (e) {
      throw Exception('Failed to delete $type: $e');
    }
  }
}
