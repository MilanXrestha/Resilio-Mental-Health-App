import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class PatientsRemoteDataSource {
  Future<List<Map<String, dynamic>>> getPatients();
}

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
}
