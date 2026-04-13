import 'package:equatable/equatable.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeaturedAudio extends AudioEvent {
  final int limit;
  final List<String>? moodFilters;

  const LoadFeaturedAudio({this.limit = 10, this.moodFilters});

  @override
  List<Object?> get props => [limit, moodFilters];
}

class LoadAllAudio extends AudioEvent {
  final int limit;

  const LoadAllAudio({this.limit = 20});

  @override
  List<Object?> get props => [limit];
}

class LoadAudioByCategory extends AudioEvent {
  final String categoryId;
  final int limit;
  final int offset;

  const LoadAudioByCategory({
    required this.categoryId,
    this.limit = 20,
    this.offset = 0,
  });

  @override
  List<Object?> get props => [categoryId, limit, offset];
}

class LoadAudioTrack extends AudioEvent {
  final String audioId;

  const LoadAudioTrack(this.audioId);

  @override
  List<Object?> get props => [audioId];
}

class IncrementPlayCount extends AudioEvent {
  final String audioId;

  const IncrementPlayCount(this.audioId);

  @override
  List<Object?> get props => [audioId];
}
