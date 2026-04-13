import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../services/auth_token_service.dart';

/// Interceptor that automatically adds authentication headers to requests
@injectable
class AuthInterceptor extends Interceptor {
  final AuthTokenService _authTokenService;

  AuthInterceptor(this._authTokenService);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip if Authorization header is already set
    if (options.headers.containsKey('Authorization')) {
      return handler.next(options);
    }

    // If no token is cached, try to recover one before proceeding
    if (!_authTokenService.hasToken) {
      await _authTokenService.ensureAuthenticated();
    }

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
      // Clear the expired token so user can re-authenticate
      _authTokenService.clear();
    }
    handler.next(err);
  }
}
