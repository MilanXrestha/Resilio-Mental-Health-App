import 'package:equatable/equatable.dart';

/// Entity representing a comment on a video
class VideoCommentEntity extends Equatable {
  final String id;
  final String videoId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final String displayName;
  final String photoUrl;

  const VideoCommentEntity({
    required this.id,
    required this.videoId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.displayName,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        videoId,
        userId,
        content,
        createdAt,
        displayName,
        photoUrl,
      ];

  factory VideoCommentEntity.fromJson(Map<String, dynamic> json) {
    // Handling both direct fields and nested user object from backend
    final user = json['users'] as Map<String, dynamic>?;
    return VideoCommentEntity(
      id: json['id'] as String? ?? '',
      videoId: json['video_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      content: json['content'] as String? ?? '',
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? DateTime.now(),
      displayName: user?['display_name'] as String? ?? json['display_name'] as String? ?? 'User',
      photoUrl: user?['photo_url'] as String? ?? json['photo_url'] as String? ?? '',
    );
  }
}
