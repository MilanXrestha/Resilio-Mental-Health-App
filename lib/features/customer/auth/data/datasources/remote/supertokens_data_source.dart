import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../domain/usecases/send_otp_usecase.dart';

/// Calls the SuperTokens FDI (Frontend Driver Interface) endpoints
/// exposed by our backend after it is initialized with supertokens-node.
///
/// Flow:
///  1. POST /auth/signinup/code         → sends OTP email, returns session info
///  2. POST /auth/signinup/code/consume → verifies OTP, returns accessToken + userId
///  3. POST /passwordless/complete      → syncs user in our Supabase DB (needs Bearer token)
@LazySingleton()
class SuperTokensDataSource {
  final Dio _dio;

  SuperTokensDataSource(this._dio);

  /// Step 1 — Request an OTP be sent to [email].
  /// Returns [OtpSessionData] containing preAuthSessionId & deviceId.
  Future<OtpSessionData> createCode({required String email}) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.stCreateCode,
        data: {'email': email},
        options: Options(
          // Override global ResponseType.bytes — ST endpoints return JSON, not protobuf
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'rid': 'passwordless', // SuperTokens recipe ID header
          },
        ),
      );

      final body = response.data as Map<String, dynamic>;

      if (body['status'] != 'OK') {
        throw Exception('SuperTokens createCode error: ${body['status']}');
      }

      return OtpSessionData(
        preAuthSessionId: body['preAuthSessionId'] as String,
        deviceId: body['deviceId'] as String,
      );
    } on DioException catch (e) {
      throw Exception(
        'Network error sending OTP: ${e.response?.data ?? e.message}',
      );
    }
  }

  /// Step 2 — Consume the OTP entered by the user.
  /// On success returns the full body from SuperTokens, which includes
  /// [accessToken] (used to authenticate Step 3) and [userId].
  Future<Map<String, dynamic>> consumeCode({
    required String preAuthSessionId,
    required String deviceId,
    required String userInputCode,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.stConsumeCode,
        data: {
          'preAuthSessionId': preAuthSessionId,
          'deviceId': deviceId,
          'userInputCode': userInputCode,
        },
        options: Options(
          // Override global ResponseType.bytes — ST endpoints return JSON, not protobuf
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'rid': 'passwordless',
          },
        ),
      );

      final body = response.data as Map<String, dynamic>;
      final status = body['status'] as String?;

      if (status == 'INCORRECT_USER_INPUT_CODE_ERROR') {
        final remaining = body['maximumCodeInputAttempts'] as int? ?? 0;
        final failed = body['failedCodeInputAttemptCount'] as int? ?? 0;
        throw Exception(
          'Incorrect OTP. ${remaining - failed} attempt(s) remaining.',
        );
      }

      if (status == 'EXPIRED_USER_INPUT_CODE_ERROR') {
        throw Exception('OTP has expired. Please request a new one.');
      }

      if (status == 'RESTART_FLOW_ERROR') {
        throw Exception('Too many failed attempts. Please start again.');
      }

      if (status != 'OK') {
        throw Exception('OTP verification failed: $status');
      }

      // Return the full body — caller needs accessToken.token for Step 3
      return body;
    } on DioException catch (e) {
      throw Exception(
        'Network error verifying OTP: ${e.response?.data ?? e.message}',
      );
    }
  }

  /// Step 3 — After a successful OTP verify, sync the user into our Supabase DB.
  ///
  /// On mobile, SuperTokens doesn't manage cookies automatically, so we forward
  /// the [accessToken] extracted from the Step 2 response as a Bearer token.
  /// The backend reads it via Session.getSession() to authenticate the request.
  Future<Map<String, dynamic>> completePasswordlessLogin({
    required String email,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.passwordlessComplete,
        data: {'email': email},
        options: Options(
          // Override global ResponseType.bytes — ST endpoints return JSON, not protobuf
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            // Forward the ST access token so the backend can verify the session
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      // Non-fatal: user is authenticated via SuperTokens session.
      // DB sync failure means we fall back to a minimal UserEntity.
      throw Exception(
        'Failed to sync user to backend: ${e.response?.data ?? e.message}',
      );
    }
  }
}
