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
