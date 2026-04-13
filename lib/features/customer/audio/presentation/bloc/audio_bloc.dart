import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/audio_repository.dart';
import 'audio_event.dart';
import 'audio_state.dart';

@lazySingleton
class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioRepository _repository;

  AudioBloc(this._repository) : super(const AudioInitial()) {
    on<LoadFeaturedAudio>(_onLoadFeaturedAudio);
    on<LoadAllAudio>(_onLoadAllAudio);
    on<LoadAudioByCategory>(_onLoadAudioByCategory);
    on<LoadAudioTrack>(_onLoadAudioTrack);
    on<IncrementPlayCount>(_onIncrementPlayCount);
  }

  Future<void> _onLoadFeaturedAudio(
    LoadFeaturedAudio event,
    Emitter<AudioState> emit,
  ) async {
    emit(const AudioLoading());

    final result = await _repository.getFeaturedAudio(
      limit: event.limit,
      moodFilters: event.moodFilters,
    );

    result.fold(
      (failure) => emit(AudioError(failure.message)),
      (tracks) => emit(AudioLoaded(tracks)),
    );
  }

  Future<void> _onLoadAllAudio(
    LoadAllAudio event,
    Emitter<AudioState> emit,
  ) async {
    emit(const AudioLoading());

    final result = await _repository.getAllAudio(limit: event.limit);

    result.fold(
      (failure) => emit(AudioError(failure.message)),
      (tracks) => emit(AudioLoaded(tracks)),
    );
  }

  Future<void> _onLoadAudioByCategory(
    LoadAudioByCategory event,
    Emitter<AudioState> emit,
  ) async {
    emit(const AudioLoading());

    final result = await _repository.getAudioByCategory(
      categoryId: event.categoryId,
      limit: event.limit,
      offset: event.offset,
    );

    result.fold(
      (failure) => emit(AudioError(failure.message)),
      (result) => emit(AudioByCategoryLoaded(
        tracks: result.tracks,
        total: result.total,
      )),
    );
  }

  Future<void> _onLoadAudioTrack(
    LoadAudioTrack event,
    Emitter<AudioState> emit,
  ) async {
    emit(const AudioLoading());

    final result = await _repository.getAudioTrackById(event.audioId);

    result.fold(
      (failure) => emit(AudioError(failure.message)),
      (track) => emit(AudioTrackLoaded(track)),
    );
  }

  Future<void> _onIncrementPlayCount(
    IncrementPlayCount event,
    Emitter<AudioState> emit,
  ) async {
    final result = await _repository.incrementPlayCount(event.audioId);

    result.fold(
      (failure) => emit(AudioError(failure.message)),
      (_) {}, // Success - no state change needed
    );
  }
}
