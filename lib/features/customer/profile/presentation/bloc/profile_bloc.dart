import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/features/customer/profile/domain/entities/profile_entity.dart';
import 'package:Resilio/features/customer/profile/domain/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
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
      (profile) => emit(ProfileUpdateSuccess(profile)),
    );
  }
}
