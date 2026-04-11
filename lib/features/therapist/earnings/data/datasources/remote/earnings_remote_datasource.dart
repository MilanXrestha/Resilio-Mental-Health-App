import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class EarningsRemoteDataSource {
  Future<Map<String, dynamic>> getEarnings();
}

@LazySingleton(as: EarningsRemoteDataSource)
class EarningsRemoteDataSourceImpl implements EarningsRemoteDataSource {
  final Dio _dio;

  EarningsRemoteDataSourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> getEarnings() async {
    try {
      final response = await _dio.get('/therapist-portal/earnings');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch earnings: $e');
    }
  }
}
