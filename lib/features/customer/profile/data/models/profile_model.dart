import 'package:Resilio/core/proto_generated/user.pb.dart' as pb;
import 'package:Resilio/features/customer/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.firebaseUid,
    required super.email,
    required super.username,
    required super.displayName,
    required super.photoUrl,
    required super.phoneNumber,
    required super.dateOfBirth,
    required super.gender,
    required super.userRole,
    required super.accountStatus,
    required super.preferencesCompleted,
    required super.fcmToken,
    required super.timezone,
    required super.language,
    required super.createdAt,
    required super.updatedAt,
    super.lastLoginAt,
  });

  factory ProfileModel.fromProto(pb.User proto) {
    return ProfileModel(
      id: proto.id,
      firebaseUid: proto.firebaseUid,
      email: proto.email,
      username: proto.username,
      displayName: proto.displayName,
      photoUrl: proto.photoUrl,
      phoneNumber: proto.phoneNumber,
      dateOfBirth: proto.dateOfBirth,
      gender: proto.gender,
      userRole: proto.userRole,
      accountStatus: proto.accountStatus,
      preferencesCompleted: proto.preferencesCompleted,
      fcmToken: proto.fcmToken,
      timezone: proto.timezone,
      language: proto.language,
      createdAt: DateTime.tryParse(proto.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(proto.updatedAt) ?? DateTime.now(),
      lastLoginAt: proto.lastLoginAt.isNotEmpty ? DateTime.tryParse(proto.lastLoginAt) : null,
    );
  }

  pb.UpdateUserRequest toUpdateUserRequest() {
    final request = pb.UpdateUserRequest()..id = id;
    if (username.isNotEmpty) request.username = username;
    if (displayName.isNotEmpty) request.displayName = displayName;
    if (photoUrl.isNotEmpty) request.photoUrl = photoUrl;
    if (phoneNumber.isNotEmpty) request.phoneNumber = phoneNumber;
    if (dateOfBirth.isNotEmpty) request.dateOfBirth = dateOfBirth;
    if (gender.isNotEmpty) request.gender = gender;
    if (timezone.isNotEmpty) request.timezone = timezone;
    if (language.isNotEmpty) request.language = language;
    if (fcmToken.isNotEmpty) request.fcmToken = fcmToken;
    return request;
  }
}
