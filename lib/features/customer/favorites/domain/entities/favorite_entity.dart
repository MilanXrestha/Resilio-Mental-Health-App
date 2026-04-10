import 'package:equatable/equatable.dart';

enum FavoriteType {
  audio,
  video,
  longVideo,
  shortVideo,
  quote,
  tip,
  image,
}

extension FavoriteTypeExtension on FavoriteType {
  String get value {
    switch (this) {
      case FavoriteType.audio:
        return 'audio';
      case FavoriteType.video:
        return 'video';
      case FavoriteType.longVideo:
        return 'longVideo';
      case FavoriteType.shortVideo:
        return 'shortVideo';
      case FavoriteType.quote:
        return 'quote';
      case FavoriteType.tip:
        return 'tip';
      case FavoriteType.image:
        return 'image';
    }
  }

  static FavoriteType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'audio':
        return FavoriteType.audio;
      case 'video':
        return FavoriteType.video;
      case 'longvideo':
        return FavoriteType.longVideo;
      case 'shortvideo':
        return FavoriteType.shortVideo;
      case 'quote':
        return FavoriteType.quote;
      case 'tip':
        return FavoriteType.tip;
      case 'image':
        return FavoriteType.image;
      default:
        return FavoriteType.audio;
    }
  }
}

class FavoriteEntity extends Equatable {
  final String id;
  final String userId;
  final String contentId;
  final FavoriteType contentType;
  final DateTime createdAt;

  const FavoriteEntity({
    required this.id,
    required this.userId,
    required this.contentId,
    required this.contentType,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, contentId, contentType, createdAt];
}
