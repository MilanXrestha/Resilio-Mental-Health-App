import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';

@LazySingleton()
class FavoriteRemoteDataSource {
  final Dio _dio;

  FavoriteRemoteDataSource(this._dio);

  Future<List<Map<String, dynamic>>> getFavorites(String userId) async {
    try {
      final response = await _dio.get('${ApiEndpoints.favoriteUser}/$userId');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.cast<Map<String, dynamic>>();
      } else {
        throw ServerFailure('Failed to get favorites: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerFailure('Network error: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw ServerFailure('Failed to get favorites: $e');
    }
  }

  Future<bool> addFavorite({
    required String userId,
    required String contentId,
    required String contentType,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.favorites}/add',
        data: {
          'user_id': userId,
          'content_id': contentId,
          'content_type': contentType,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      // 201 = created, 200 = success, alreadyExists = already saved (treat as success)
      if (response.statusCode == 201 || response.statusCode == 200) return true;
      final body = response.data;
      if (body is Map && body['data'] is Map && body['data']['alreadyExists'] == true) return true;
      return body != null && body['success'] == true;
    } on DioException catch (e) {
      throw ServerFailure('Failed to add favorite: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw ServerFailure('Failed to add favorite: $e');
    }
  }

  Future<bool> removeFavorite({
    required String userId,
    required String contentId,
    required String contentType,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.favorites}/remove',
        data: {
          'user_id': userId,
          'content_id': contentId,
          'content_type': contentType,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return response.statusCode == 200 ||
          (response.data != null && response.data['success'] == true);
    } on DioException catch (e) {
      throw ServerFailure('Failed to remove favorite: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw ServerFailure('Failed to remove favorite: $e');
    }
  }

  Future<bool> isFavorited({
    required String userId,
    required String contentId,
    required String contentType,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.favoriteStatus,
        queryParameters: {
          'user_id': userId,
          'content_id': contentId,
          'content_type': contentType,
        },
      );

      if (response.statusCode == 200) {
        return response.data['data']['isFavorited'] ?? false;
      }
      return false;
    } on DioException catch (e) {
      throw ServerFailure('Failed to check favorite status: ${e.message ?? 'Unknown error'}');
    } catch (e) {
      throw ServerFailure('Failed to check favorite status: $e');
    }
  }
}
