import 'package:equatable/equatable.dart';

import '../../domain/entities/audio_entity.dart';

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object?> get props => [];
}

class AudioInitial extends AudioState {
  const AudioInitial();
}

class AudioLoading extends AudioState {
  const AudioLoading();
}

class AudioLoaded extends AudioState {
  final List<AudioEntity> featuredTracks;

  const AudioLoaded(this.featuredTracks);

  @override
  List<Object?> get props => [featuredTracks];
}

class AudioByCategoryLoaded extends AudioState {
  final List<AudioEntity> tracks;
  final int total;

  const AudioByCategoryLoaded({required this.tracks, required this.total});

  @override
  List<Object?> get props => [tracks, total];
}

class AudioTrackLoaded extends AudioState {
  final AudioEntity track;

  const AudioTrackLoaded(this.track);

  @override
  List<Object?> get props => [track];
}

class AudioError extends AudioState {
  final String message;

  const AudioError(this.message);

  @override
  List<Object?> get props => [message];
}
