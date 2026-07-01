import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class PatientsRemoteDataSource {
  Future<List<Map<String, dynamic>>> getPatients();

  /// Mood logs for a patient. Throws [MoodNotSharedException] if the patient
  /// has not shared their logs with this therapist (backend returns 403).
  Future<List<Map<String, dynamic>>> getPatientMoods(String patientId);
}

/// Thrown when a therapist requests moods a patient hasn't shared.
class MoodNotSharedException implements Exception {}

@LazySingleton(as: PatientsRemoteDataSource)
class PatientsRemoteDataSourceImpl implements PatientsRemoteDataSource {
  final Dio _dio;

  PatientsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<Map<String, dynamic>>> getPatients() async {
    try {
      final response = await _dio.get('/therapist-portal/patients');
      final list = response.data['patients'] as List<dynamic>? ?? [];
      return list.cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to fetch patients: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getPatientMoods(String patientId) async {
    try {
      final response = await _dio.get(
        '/therapist-portal/patients/$patientId/moods',
        options: Options(
          responseType: ResponseType.json,
          headers: const {'Accept': 'application/json'},
        ),
      );
      final list = response.data['moods'] as List<dynamic>? ?? [];
      return list.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) throw MoodNotSharedException();
      throw Exception('Failed to fetch patient moods: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch patient moods: $e');
    }
  }
}
