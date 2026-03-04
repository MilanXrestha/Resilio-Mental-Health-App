import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../services/auth_token_service.dart';

/// Interceptor that automatically adds authentication headers to requests
@injectable
class AuthInterceptor extends Interceptor {
  final AuthTokenService _authTokenService;

  AuthInterceptor(this._authTokenService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Skip if Authorization header is already set
    if (options.headers.containsKey('Authorization')) {
      return handler.next(options);
    }

    // Add auth token if available
    final token = _authTokenService.token;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 errors - token might be expired
    if (err.response?.statusCode == 401) {
      // You could emit an event or clear the token here
      // _authTokenService.clear();
    }
    handler.next(err);
  }
}
