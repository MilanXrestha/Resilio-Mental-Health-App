import 'package:equatable/equatable.dart';

/// Audio entity representing a meditation/calming audio track
class AudioEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String artistName;
  final String audioUrl;
  final String coverImageUrl;
  final String thumbnailUrl;
  final int durationSeconds;
  final String categoryId;
  final List<String> moodTags;
  final bool isFeatured;
  final bool isPremium;
  final int sortOrder;
  final int playCount;
  final int likeCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AudioEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.artistName,
    required this.audioUrl,
    required this.coverImageUrl,
    required this.thumbnailUrl,
    required this.durationSeconds,
    required this.categoryId,
    required this.moodTags,
    required this.isFeatured,
    required this.isPremium,
    required this.sortOrder,
    this.playCount = 0,
    this.likeCount = 0,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a copy with updated fields
  AudioEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? artistName,
    String? audioUrl,
    String? coverImageUrl,
    String? thumbnailUrl,
    int? durationSeconds,
    String? categoryId,
    List<String>? moodTags,
    bool? isFeatured,
    bool? isPremium,
    int? sortOrder,
    int? playCount,
    int? likeCount,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AudioEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      artistName: artistName ?? this.artistName,
      audioUrl: audioUrl ?? this.audioUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      categoryId: categoryId ?? this.categoryId,
      moodTags: moodTags ?? this.moodTags,
      isFeatured: isFeatured ?? this.isFeatured,
      isPremium: isPremium ?? this.isPremium,
      sortOrder: sortOrder ?? this.sortOrder,
      playCount: playCount ?? this.playCount,
      likeCount: likeCount ?? this.likeCount,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        artistName,
        audioUrl,
        coverImageUrl,
        thumbnailUrl,
        durationSeconds,
        categoryId,
        moodTags,
        isFeatured,
        isPremium,
        sortOrder,
        playCount,
        likeCount,
        isActive,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() => 'AudioEntity(id: $id, title: $title, artist: $artistName)';

  /// Helper method to format duration as MM:SS
  String get formattedDuration {
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
