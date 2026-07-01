import 'package:equatable/equatable.dart';

/// Video type enum for distinguishing between short reels and long-form content
enum VideoType {
  shortForm, // Short reels (TikTok/Instagram Reels style)
  longForm,  // Long videos (YouTube/therapy sessions)
  unknown,
}

/// Video entity representing a video track (short reel or long-form therapy session)
class VideoEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String artistName;
  final String videoUrl;
  final String thumbnailUrl;
  final String coverImageUrl;
  final int durationSeconds;
  final String categoryId;
  final List<String> moodTags;
  final VideoType videoType;
  final double aspectRatio;
  final bool isFeatured;
  final bool isPremium;
  final bool isActive;
  final int sortOrder;
  final int playCount;
  final int likeCount;
  final int shareCount;
  final int commentCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const VideoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.artistName,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.coverImageUrl,
    required this.durationSeconds,
    required this.categoryId,
    required this.moodTags,
    required this.videoType,
    required this.aspectRatio,
    required this.isFeatured,
    required this.isPremium,
    required this.isActive,
    required this.sortOrder,
    this.playCount = 0,
    this.likeCount = 0,
    this.shareCount = 0,
    this.commentCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a copy with updated fields
  VideoEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? artistName,
    String? videoUrl,
    String? thumbnailUrl,
    String? coverImageUrl,
    int? durationSeconds,
    String? categoryId,
    List<String>? moodTags,
    VideoType? videoType,
    double? aspectRatio,
    bool? isFeatured,
    bool? isPremium,
    bool? isActive,
    int? sortOrder,
    int? playCount,
    int? likeCount,
    int? shareCount,
    int? commentCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VideoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      artistName: artistName ?? this.artistName,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      categoryId: categoryId ?? this.categoryId,
      moodTags: moodTags ?? this.moodTags,
      videoType: videoType ?? this.videoType,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      isFeatured: isFeatured ?? this.isFeatured,
      isPremium: isPremium ?? this.isPremium,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      playCount: playCount ?? this.playCount,
      likeCount: likeCount ?? this.likeCount,
      shareCount: shareCount ?? this.shareCount,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Get formatted duration as string (MM:SS or HH:MM:SS for long videos)
  String get formattedDuration {
    final hours = durationSeconds ~/ 3600;
    final minutes = (durationSeconds % 3600) ~/ 60;
    final seconds = durationSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  /// Check if this is a short video (reel)
  bool get isShortVideo => videoType == VideoType.shortForm;

  /// Check if this is a long video (therapy session)
  bool get isLongVideo => videoType == VideoType.longForm;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        artistName,
        videoUrl,
        thumbnailUrl,
        coverImageUrl,
        durationSeconds,
        categoryId,
        moodTags,
        videoType,
        aspectRatio,
        isFeatured,
        isPremium,
        isActive,
        sortOrder,
        playCount,
        likeCount,
        shareCount,
        commentCount,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'VideoEntity(id: $id, title: $title, videoType: $videoType, duration: $formattedDuration)';
  }
}
