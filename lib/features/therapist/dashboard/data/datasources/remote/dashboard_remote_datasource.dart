import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class TherapistDashboardRemoteDataSource {
  Future<Map<String, dynamic>> getStats();
  Future<bool> notifyCall(String appointmentId);
}

@LazySingleton(as: TherapistDashboardRemoteDataSource)
class TherapistDashboardRemoteDataSourceImpl implements TherapistDashboardRemoteDataSource {
  final Dio _dio;

  TherapistDashboardRemoteDataSourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getStats() async {
    try {
      final response = await _dio.get('/therapist-portal/dashboard');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch dashboard stats: $e');
    }
  }

  @override
  Future<bool> notifyCall(String appointmentId) async {
    try {
      await _dio.post('/therapist-portal/call/notify', data: {'appointmentId': appointmentId});
      return true;
    } catch (e) {
      throw Exception('Failed to notify call: $e');
    }
  }
}
