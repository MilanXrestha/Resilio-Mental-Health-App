part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final ProfileEntity profile;

  const UpdateProfileEvent(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// Upload a new avatar to Cloudinary, then save the resulting URL to the backend.
class UploadAvatarEvent extends ProfileEvent {
  final String filePath;
  final ProfileEntity currentProfile;

  const UploadAvatarEvent({required this.filePath, required this.currentProfile});

  @override
  List<Object?> get props => [filePath, currentProfile];
}
