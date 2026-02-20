import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:resilio/core/constants/api_endpoints.dart';
import 'package:resilio/core/proto_generated/auth.pb.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login({required LoginRequest request});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginResponse> login({required LoginRequest request}) async {
    final response = await _dio.post(
      ApiEndpoints.login,
      data: request,
    );
    
    // Dio with ResponseType.bytes returns Uint8List
    return LoginResponse.fromBuffer(response.data);
  }
}
