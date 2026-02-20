import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'proto_transformer.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.resilio.com',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        // Protobuf uses binary, but we can set default content type
        contentType: 'application/x-protobuf',
        responseType: ResponseType.bytes,
      ),
    );

    dio.transformer = ProtobufTransformer();

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  }
}
