import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class AppointmentsRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAppointments({String? status, String? date});
  Future<bool> updateStatus(String id, String status);
}

@LazySingleton(as: AppointmentsRemoteDataSource)
class AppointmentsRemoteDataSourceImpl implements AppointmentsRemoteDataSource {
  final Dio _dio;

  AppointmentsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Map<String, dynamic>>> getAppointments({String? status, String? date}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (status != null) queryParams['status'] = status;
      if (date != null) queryParams['date'] = date;

      final response = await _dio.get(
        '/therapist-portal/appointments',
        queryParameters: queryParams.isEmpty ? null : queryParams,
      );

      final list = response.data['appointments'] as List<dynamic>? ?? [];
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to fetch appointments: $e');
    }
  }

  @override
  Future<bool> updateStatus(String id, String status) async {
    try {
      await _dio.patch(
        '/therapist-portal/appointments/$id/status',
        data: {'status': status},
      );
      return true;
    } catch (e) {
      throw Exception('Failed to update appointment status: $e');
    }
  }
}
