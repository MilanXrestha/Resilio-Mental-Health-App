import 'package:equatable/equatable.dart';

/// User profile entity for dashboard
class UserProfile extends Equatable {
  final String uid;
  final String firstName;
  final String? lastName;
  final String? email;
  final String? profilePictureUrl;

  const UserProfile({
    required this.uid,
    required this.firstName,
    this.lastName,
    this.email,
    this.profilePictureUrl,
  });

  @override
  List<Object?> get props => [uid, firstName, lastName, email, profilePictureUrl];
}