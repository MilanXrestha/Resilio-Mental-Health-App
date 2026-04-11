import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/services/cloudinary_service.dart';
import 'package:Resilio/features/customer/profile/domain/entities/profile_entity.dart';
import 'package:Resilio/features/customer/profile/domain/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  final CloudinaryService _cloudinaryService;

  ProfileBloc(this._repository, this._cloudinaryService) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<UploadAvatarEvent>(_onUploadAvatar);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await _repository.getProfile();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileUpdating(currentState.profile));
    }

    final result = await _repository.updateProfile(event.profile);
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) {
        emit(ProfileUpdateSuccess(profile));
        // Transition immediately to ProfileLoaded so the profile screen
        // doesn't get stuck on a white/empty page after the edit screen pops.
        emit(ProfileLoaded(profile));
      },
    );
  }

  Future<void> _onUploadAvatar(
    UploadAvatarEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileAvatarUploading());

    try {
      // Evict the old cached image so the new one is fetched fresh
      if (event.currentProfile.photoUrl.isNotEmpty) {
        PaintingBinding.instance.imageCache
            .evict(NetworkImage(event.currentProfile.photoUrl));
      }

      final secureUrl = await _cloudinaryService.uploadProfileImage(
        File(event.filePath),
        event.currentProfile.id,
      );

      final updatedProfile = ProfileEntity(
        id: event.currentProfile.id,
        firebaseUid: event.currentProfile.firebaseUid,
        email: event.currentProfile.email,
        username: event.currentProfile.username,
        displayName: event.currentProfile.displayName,
        photoUrl: secureUrl,
        phoneNumber: event.currentProfile.phoneNumber,
        dateOfBirth: event.currentProfile.dateOfBirth,
        gender: event.currentProfile.gender,
        userRole: event.currentProfile.userRole,
        accountStatus: event.currentProfile.accountStatus,
        preferencesCompleted: event.currentProfile.preferencesCompleted,
        fcmToken: event.currentProfile.fcmToken,
        timezone: event.currentProfile.timezone,
        language: event.currentProfile.language,
        createdAt: event.currentProfile.createdAt,
        updatedAt: DateTime.now(),
        lastLoginAt: event.currentProfile.lastLoginAt,
      );

      final result = await _repository.updateProfile(updatedProfile);
      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (profile) {
          emit(ProfileUpdateSuccess(profile));
          emit(ProfileLoaded(profile));
        },
      );
    } catch (e) {
      emit(ProfileError('Failed to upload avatar: $e'));
    }
  }
}
