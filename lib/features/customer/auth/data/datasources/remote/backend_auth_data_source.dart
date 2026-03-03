import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/proto_generated/user.pb.dart';

/// Data source for backend API communication using Protocol Buffers
@LazySingleton()
class BackendAuthDataSource {
  final Dio _dio;

  BackendAuthDataSource(this._dio);

  /// Sync Firebase user to backend using Protobuf
  Future<User> syncUser({
    required firebase.User firebaseUser,
    String? fcmToken,
  }) async {
    try {
      final idToken = await firebaseUser.getIdToken();
      
      final request = SyncUserRequest(
        firebaseUid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName ?? '',
        photoUrl: firebaseUser.photoURL ?? '',
      );

      final response = await _dio.post(
        ApiEndpoints.syncUser,
        data: request, // Interceptor will handle conversion to bytes
        options: Options(
          headers: {
            // No Authorization header needed for sync endpoint (public)
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return User.fromBuffer(response.data as Uint8List);
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

  /// Get current user profile from backend using Protobuf
  Future<User> getUserProfile({
    required String idToken,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.me,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
            'Accept': 'application/x-protobuf',
          },
        ),
      );

      if (response.statusCode == 200) {
        return User.fromBuffer(response.data as Uint8List);
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

  /// Update user profile in backend using Protobuf
  Future<User> updateUserProfile({
    required String idToken,
    required UpdateUserRequest updates,
  }) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.me,
        data: updates,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return User.fromBuffer(response.data as Uint8List);
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
