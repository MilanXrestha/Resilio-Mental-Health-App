import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/constants/api_endpoints.dart';
import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/proto_generated/user.pb.dart';

/// Data source for preference API communication using Protocol Buffers
@LazySingleton()
class PreferenceRemoteDataSource {
  final Dio _dio;

  PreferenceRemoteDataSource(this._dio);

  /// Get all available preferences using Protobuf
  Future<List<Preference>> getAllPreferences() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.preferences,
        options: Options(headers: {'Accept': 'application/x-protobuf'}),
      );

      if (response.statusCode == 200) {
        final listResponse = ListPreferencesResponse.fromBuffer(response.data as Uint8List);
        return listResponse.preferences;
      } else {
        throw ServerFailure('Failed to get preferences');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message}');
    } catch (e) {
      throw ServerFailure('Failed to get preferences: $e');
    }
  }

  /// Get user's selected preferences using Protobuf
  Future<List<Preference>> getUserPreferences({
    required String idToken,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.preferencesMe,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
            'Accept': 'application/x-protobuf',
          },
        ),
      );

      if (response.statusCode == 200) {
        final listResponse = ListPreferencesResponse.fromBuffer(response.data as Uint8List);
        return listResponse.preferences;
      } else {
        throw ServerFailure('Failed to get user preferences');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message}');
    } catch (e) {
      throw ServerFailure('Failed to get user preferences: $e');
    }
  }

  /// Save user preferences using Protobuf
  Future<List<Preference>> saveUserPreferences({
    required String idToken,
    required List<String> preferenceIds,
  }) async {
    try {
      final request = SavePreferencesRequest(preferenceIds: preferenceIds);

      final response = await _dio.post(
        ApiEndpoints.preferencesMe,
        data: request,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final listResponse = ListPreferencesResponse.fromBuffer(response.data as Uint8List);
        return listResponse.preferences;
      } else {
        throw ServerFailure('Failed to save preferences');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message}');
    } catch (e) {
      throw ServerFailure('Failed to save preferences: $e');
    }
  }

  /// Check if user has completed preferences using Protobuf
  Future<bool> hasCompletedPreferences({
    required String idToken,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.preferencesMeCompleted,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
            'Accept': 'application/x-protobuf',
          },
        ),
      );

      if (response.statusCode == 200) {
        final status = PreferenceCompletionStatus.fromBuffer(response.data as Uint8List);
        return status.completed;
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
