import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/constants/api_endpoints.dart';
import 'package:Resilio/core/errors/failures.dart';

/// Data source for preference API communication
/// Handles all HTTP calls to the preferences backend
@LazySingleton()
class PreferenceRemoteDataSource {
  final Dio _dio;

  PreferenceRemoteDataSource(this._dio);

  /// Get all available preferences (public endpoint, no auth)
  Future<List<Map<String, dynamic>>> getAllPreferences() async {
    try {
      final response = await _dio.get(ApiEndpoints.preferences);

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'];
        return data.cast<Map<String, dynamic>>();
      } else {
        throw ServerFailure('Failed to get preferences');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message}');
    } catch (e) {
      throw ServerFailure('Failed to get preferences: $e');
    }
  }

  /// Get user's selected preferences (requires auth)
  Future<List<Map<String, dynamic>>> getUserPreferences({
    required String idToken,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.preferencesMe,
        options: Options(
          headers: {'Authorization': 'Bearer $idToken'},
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'];
        return data.cast<Map<String, dynamic>>();
      } else {
        throw ServerFailure('Failed to get user preferences');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message}');
    } catch (e) {
      throw ServerFailure('Failed to get user preferences: $e');
    }
  }

  /// Save user preferences (requires auth)
  Future<List<Map<String, dynamic>>> saveUserPreferences({
    required String idToken,
    required List<String> preferenceIds,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.preferencesMe,
        data: {'preferenceIds': preferenceIds},
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'];
        return data.cast<Map<String, dynamic>>();
      } else {
        throw ServerFailure('Failed to save preferences');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message}');
    } catch (e) {
      throw ServerFailure('Failed to save preferences: $e');
    }
  }

  /// Check if user has completed preferences (requires auth)
  Future<bool> hasCompletedPreferences({
    required String idToken,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.preferencesMeCompleted,
        options: Options(
          headers: {'Authorization': 'Bearer $idToken'},
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return response.data['data']['completed'] ?? false;
      } else {
        throw ServerFailure('Failed to check preferences completion');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message}');
    } catch (e) {
      throw ServerFailure('Failed to check preferences completion: $e');
    }
  }
}
