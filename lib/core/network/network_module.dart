import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/api_endpoints.dart';
import 'protobuf_interceptor.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.bytes, // Important for protobuf
      ),
    );

    dio.interceptors.addAll([
      ProtobufInterceptor(),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    ]);

    return dio;
  }
}
