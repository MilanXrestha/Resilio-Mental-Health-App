import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String firebaseUid;
  final String email;
  final String username;
  final String displayName;
  final String photoUrl;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String userRole;
  final String accountStatus;
  final bool preferencesCompleted;
  final String fcmToken;
  final String timezone;
  final String language;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProfileEntity({
    required this.id,
    required this.firebaseUid,
    required this.email,
    required this.username,
    required this.displayName,
    required this.photoUrl,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.userRole,
    required this.accountStatus,
    required this.preferencesCompleted,
    required this.fcmToken,
    required this.timezone,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        firebaseUid,
        email,
        username,
        displayName,
        photoUrl,
        phoneNumber,
        dateOfBirth,
        gender,
        userRole,
        accountStatus,
        preferencesCompleted,
        fcmToken,
        timezone,
        language,
        createdAt,
        updatedAt,
      ];
}
