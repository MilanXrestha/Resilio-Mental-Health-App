import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/core/constants/api_endpoints.dart';
import 'package:Resilio/core/proto_generated/user.pb.dart' as pb;
import 'package:Resilio/features/customer/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel?> getProfile();
  Future<ProfileModel?> updateProfile(ProfileModel profile);
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSourceImpl(this._dio);

  @override
  Future<ProfileModel?> getProfile() async {
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
      final user = pb.User.fromBuffer(bytes);
      return ProfileModel.fromProto(user);
    }
    return null;
  }

  @override
  Future<ProfileModel?> updateProfile(ProfileModel profile) async {
    final updateRequest = profile.toUpdateUserRequest();
    
    final response = await _dio.patch(
      ApiEndpoints.me,
      data: updateRequest.writeToBuffer(),
      options: Options(
        headers: {
          'Content-Type': 'application/x-protobuf',
          'Accept': 'application/x-protobuf',
          'X-Protobuf-Message-Type': 'UpdateUserRequest',
        },
        responseType: ResponseType.bytes,
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      final bytes = response.data as List<int>;
      final user = pb.User.fromBuffer(bytes);
      return ProfileModel.fromProto(user);
    }
    return null;
  }
}
