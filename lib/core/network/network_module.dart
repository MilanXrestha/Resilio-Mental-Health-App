import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/api_endpoints.dart';
import '../services/auth_token_service.dart';
import 'auth_interceptor.dart';
import 'protobuf_interceptor.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AuthTokenService authTokenService) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.bytes, // Important for protobuf
      ),
    );

    dio.interceptors.addAll([
      // Auth interceptor - adds Authorization header automatically
      AuthInterceptor(authTokenService),

      // Protobuf interceptor - handles protobuf serialization
      ProtobufInterceptor(),

      // Logger - for debugging
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: false,
      ),
    ]);

    return dio;
  }
}
