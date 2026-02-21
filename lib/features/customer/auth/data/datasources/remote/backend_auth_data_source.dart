import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';

/// Data source for backend API communication
/// Syncs Firebase authenticated users to backend database
@LazySingleton()
class BackendAuthDataSource {
  final Dio _dio;

  BackendAuthDataSource(this._dio);

  /// Sync Firebase user to backend
  /// This should be called after successful Firebase authentication
  Future<Map<String, dynamic>> syncUser({
    required User firebaseUser,
    String? fcmToken,
  }) async {
    try {
      final idToken = await firebaseUser.getIdToken();
      
      final response = await _dio.post(
        ApiEndpoints.syncUser,
        data: {
          'uid': firebaseUser.uid,
          'email': firebaseUser.email,
          'displayName': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoURL,
          'fcmToken': fcmToken,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      } else {
        throw ServerFailure('Failed to sync user: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure(
        'Network error: ${e.message ?? 'Unknown error'}',
      );
    } catch (e) {
      throw ServerFailure('Failed to sync user: $e');
    }
  }

  /// Get current user profile from backend
  Future<Map<String, dynamic>> getUserProfile({
    required String idToken,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.me,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw ServerFailure('Failed to get user profile: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure(
        'Network error: ${e.message ?? 'Unknown error'}',
      );
    } catch (e) {
      throw ServerFailure('Failed to get user profile: $e');
    }
  }

  /// Update user profile in backend
  Future<Map<String, dynamic>> updateUserProfile({
    required String idToken,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.me,
        data: updates,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw ServerFailure('Failed to update profile: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure(
        'Network error: ${e.message ?? 'Unknown error'}',
      );
    } catch (e) {
      throw ServerFailure('Failed to update profile: $e');
    }
  }
}
