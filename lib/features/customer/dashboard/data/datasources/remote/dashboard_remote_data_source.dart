import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/proto_generated/user.pb.dart';
import '../../../domain/entities/user_profile_entity.dart';

abstract class DashboardRemoteDataSource {
  /// Gets user profile from backend API
  /// Authorization header is added automatically by AuthInterceptor
  Future<UserProfile?> getUserProfile();
}

@LazySingleton(as: DashboardRemoteDataSource)
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio _dio;

  DashboardRemoteDataSourceImpl(this._dio);

  @override
  Future<UserProfile?> getUserProfile() async {
    try {
      // Auth interceptor will add Authorization header automatically
      final response = await _dio.get(
        ApiEndpoints.me,
        options: Options(
          headers: {
            'Accept': 'application/x-protobuf',
            'X-Protobuf-Message-Type': 'User',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final user = User.fromBuffer(bytes);

        return UserProfile(
          uid: user.id,
          firstName: user.displayName.isNotEmpty
              ? user.displayName
              : (user.username.isNotEmpty ? user.username : 'User'),
          lastName: '',
          email: user.email,
          profilePictureUrl: user.photoUrl.isNotEmpty ? user.photoUrl : null,
        );
      }

      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        throw const NetworkFailure('Unauthorized access');
      }
      if (e.response?.statusCode == 404) {
        throw const NetworkFailure('User profile not found');
      }
      throw NetworkFailure('Failed to fetch user profile: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch user profile: $e');
    }
  }
}