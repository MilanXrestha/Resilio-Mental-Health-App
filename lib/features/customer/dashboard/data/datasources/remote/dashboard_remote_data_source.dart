import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/proto_generated/user.pb.dart';
import '../../../domain/entities/user_profile_entity.dart';

/// Remote data source for dashboard operations - uses Node.js backend API
abstract class DashboardRemoteDataSource {
  /// Gets user profile from backend API
  Future<UserProfile?> getUserProfile(String userId, String idToken);
}

@LazySingleton(as: DashboardRemoteDataSource)
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio _dio;

  DashboardRemoteDataSourceImpl(this._dio);

  @override
  Future<UserProfile?> getUserProfile(String userId, String idToken) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.me,
        options: Options(
          headers: {
            'Authorization': 'Bearer $idToken',
            'Accept': 'application/x-protobuf',
            'X-Protobuf-Message-Type': 'User',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        // Parse protobuf User response from backend
        final bytes = response.data as List<int>;
        final user = User.fromBuffer(bytes);
        
        return UserProfile(
          uid: user.id,
          firstName: user.displayName.isNotEmpty ? user.displayName : (user.username.isNotEmpty ? user.username : 'User'),
          lastName: '',
          email: user.email,
          profilePictureUrl: user.photoUrl,
        );
      }

      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        throw NetworkFailure('Unauthorized access');
      }
      throw NetworkFailure('Failed to fetch user profile: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch user profile: $e');
    }
  }
}
