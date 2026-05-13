import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../../../../../core/database/database_helper.dart';
import '../../domain/entities/audio_entity.dart';

abstract class AudioLocalDataSource {
  Future<void> cacheAudioTracks(List<AudioEntity> tracks);
  Future<List<AudioEntity>> getCachedAudioTracks();
  Future<void> clearCache();
}

@LazySingleton(as: AudioLocalDataSource)
class AudioLocalDataSourceImpl implements AudioLocalDataSource {
  final DatabaseHelper _databaseHelper;
  static const String _keyAudioTracks = 'audio_tracks';

  AudioLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> cacheAudioTracks(List<AudioEntity> tracks) async {
    final existingTracks = await getCachedAudioTracks();
    final merged = <String, AudioEntity>{
      for (final track in existingTracks) track.id: track,
      for (final track in tracks) track.id: track,
    };

    final data = merged.values
        .map(
          (t) => {
            'id': t.id,
            'title': t.title,
            'description': t.description,
            'artistName': t.artistName,
            'audioUrl': t.audioUrl,
            'coverImageUrl': t.coverImageUrl,
            'thumbnailUrl': t.thumbnailUrl,
            'durationSeconds': t.durationSeconds,
            'categoryId': t.categoryId,
            'moodTags': t.moodTags,
            'isFeatured': t.isFeatured,
            'isPremium': t.isPremium,
            'sortOrder': t.sortOrder,
            'playCount': t.playCount,
            'likeCount': t.likeCount,
            'isActive': t.isActive,
            'createdAt': t.createdAt.toIso8601String(),
            'updatedAt': t.updatedAt.toIso8601String(),
          },
        )
        .toList();
    await _databaseHelper.saveToCache(
      _keyAudioTracks,
      utf8.encode(jsonEncode(data)),
    );
  }

  @override
  Future<List<AudioEntity>> getCachedAudioTracks() async {
    final bytes = await _databaseHelper.getFromCache(_keyAudioTracks);
    if (bytes != null) {
      try {
        final List<dynamic> data = jsonDecode(utf8.decode(bytes));
        return data
            .map(
              (t) => AudioEntity(
                id: t['id'] ?? '',
                title: t['title'] ?? '',
                description: t['description'] ?? '',
                artistName: t['artistName'] ?? '',
                audioUrl: t['audioUrl'] ?? '',
                coverImageUrl: t['coverImageUrl'] ?? '',
                thumbnailUrl: t['thumbnailUrl'] ?? '',
                durationSeconds: t['durationSeconds'] ?? 0,
                categoryId: t['categoryId'] ?? '',
                moodTags: List<String>.from(t['moodTags'] ?? []),
                isFeatured: t['isFeatured'] ?? false,
                isPremium: t['isPremium'] ?? false,
                sortOrder: t['sortOrder'] ?? 0,
                playCount: t['playCount'] ?? 0,
                likeCount: t['likeCount'] ?? 0,
                isActive: t['isActive'] ?? true,
                createdAt: DateTime.parse(
                  t['createdAt'] ?? DateTime.now().toIso8601String(),
                ),
                updatedAt: DateTime.parse(
                  t['updatedAt'] ?? DateTime.now().toIso8601String(),
                ),
              ),
            )
            .toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  @override
  Future<void> clearCache() async {
    await _databaseHelper.clearCache();
  }
}
