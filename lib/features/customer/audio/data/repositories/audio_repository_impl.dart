import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/proto_generated/audio.pb.dart';
import '../../domain/entities/audio_entity.dart';
import '../../domain/repositories/audio_repository.dart';
import '../datasources/audio_remote_datasource.dart';

@LazySingleton(as: AudioRepository)
class AudioRepositoryImpl implements AudioRepository {
  final AudioRemoteDataSource _remoteDataSource;

  AudioRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<AudioEntity>>> getFeaturedAudio({
    int limit = 10,
    List<String>? moodFilters,
  }) async {
    try {
      final tracks = await _remoteDataSource.getFeaturedAudio(
        limit: limit,
        moodFilters: moodFilters,
      );

      return Right(tracks.map(_mapToEntity).toList());
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, AudioListResult>> getAudioByCategory({
    required String categoryId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final result = await _remoteDataSource.getAudioByCategory(
        categoryId: categoryId,
        limit: limit,
        offset: offset,
      );

      return Right(AudioListResult(
        tracks: result.tracks.map(_mapToEntity).toList(),
        total: result.total,
      ));
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, AudioEntity>> getAudioTrackById(String audioId) async {
    try {
      final track = await _remoteDataSource.getAudioTrackById(audioId);
      return Right(_mapToEntity(track));
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, PlayCountResult>> incrementPlayCount(String audioId) async {
    try {
      await _remoteDataSource.incrementPlayCount(audioId);
      return Right(PlayCountResult(success: true, newCount: 0));
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  AudioEntity _mapToEntity(AudioTrack proto) {
    return AudioEntity(
      id: proto.id,
      title: proto.title,
      description: proto.description,
      artistName: proto.artistName,
      audioUrl: proto.audioUrl,
      coverImageUrl: proto.coverImageUrl,
      thumbnailUrl: proto.thumbnailUrl,
      durationSeconds: proto.durationSeconds,
      categoryId: proto.categoryId,
      moodTags: proto.moodTags.toList(),
      isFeatured: proto.isFeatured,
      isPremium: proto.isPremium,
      sortOrder: proto.sortOrder,
      playCount: proto.playCount,
      likeCount: proto.likeCount,
      isActive: proto.isActive,
      createdAt: DateTime.parse(proto.createdAt),
      updatedAt: DateTime.parse(proto.updatedAt),
    );
  }
}
