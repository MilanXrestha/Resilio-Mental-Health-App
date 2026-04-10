import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/therapist/dashboard/domain/repositories/therapist_repository.dart';

@LazySingleton(as: TherapistRepository)
class TherapistRepositoryImpl implements TherapistRepository {
  final Dio _dio;

  TherapistRepositoryImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getMyProfile() async {
    try {
      final response = await _dio.get('/users/me');
      return response.data['user'] as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  @override
  Future<List<dynamic>> getMyAppointments() async {
    try {
      // In a real app we might pass therapistId query here or backend handles via token
      final response = await _dio.get('/appointments');
      return response.data['appointments'] as List<dynamic>? ?? [];
    } catch (e) {
      // Return empty instead of crashing if route has issues for now
      return [];
    }
  }

  @override
  Future<bool> updateAvailability(Map<String, dynamic> availabilityData) async {
    try {
      // Assuming a patch endpoint for user profile / therapist specifics
      await _dio.put('/users/me', data: {
        'availabilityJson': availabilityData,
      });
      return true;
    } catch (e) {
      throw Exception('Failed to update availability: $e');
    }
  }
}
