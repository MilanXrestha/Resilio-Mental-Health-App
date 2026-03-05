import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/audio_entity.dart';

abstract class AudioRepository {
  Future<Either<Failure, List<AudioEntity>>> getFeaturedAudio({
    int limit = 10,
    List<String>? moodFilters,
  });

  Future<Either<Failure, AudioListResult>> getAudioByCategory({
    required String categoryId,
    int limit = 20,
    int offset = 0,
  });

  Future<Either<Failure, AudioEntity>> getAudioTrackById(String audioId);

  Future<Either<Failure, PlayCountResult>> incrementPlayCount(String audioId);
}

class AudioListResult {
  final List<AudioEntity> tracks;
  final int total;

  AudioListResult({required this.tracks, required this.total});
}

class PlayCountResult {
  final bool success;
  final int newCount;

  PlayCountResult({required this.success, required this.newCount});
}
