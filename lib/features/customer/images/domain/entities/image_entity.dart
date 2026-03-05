import 'package:equatable/equatable.dart';

enum ImageType {
  motivation, // Motivational and inspirational images
  nature, // Nature scenes and landscapes
  quotes, // Quote-based images
  abstract, // Abstract art
  spiritual, // Spiritual and religious imagery
  general, // General purpose images
  unknown,
}

class ImageEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String thumbnailUrl;
  final String author;
  final String authorIconUrl;
  final String categoryId;
  final List<String> preferenceIds;
  final ImageType imageType;
  final bool isFeatured;
  final bool isPremium;
  final int resolutionWidth;
  final int resolutionHeight;
  final int fileSizeBytes;
  final int downloadCount;
  final int sortOrder;
  final String metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ImageEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.thumbnailUrl = '',
    this.author = '',
    this.authorIconUrl = '',
    this.categoryId = '',
    this.preferenceIds = const [],
    this.imageType = ImageType.general,
    this.isFeatured = false,
    this.isPremium = false,
    this.resolutionWidth = 0,
    this.resolutionHeight = 0,
    this.fileSizeBytes = 0,
    this.downloadCount = 0,
    this.sortOrder = 0,
    this.metadata = '{}',
    required this.createdAt,
    required this.updatedAt,
  });

  /// Get aspect ratio for display
  double get aspectRatio {
    if (resolutionWidth == 0 || resolutionHeight == 0) {
      return 1.0; // Default to square
    }
    return resolutionWidth / resolutionHeight;
  }

  /// Get formatted file size
  String get formattedFileSize {
    if (fileSizeBytes < 1024) return '$fileSizeBytes B';
    if (fileSizeBytes < 1024 * 1024) return '${(fileSizeBytes / 1024).toStringAsFixed(1)} KB';
    return '${(fileSizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Get image type as string
  String get imageTypeString {
    switch (imageType) {
      case ImageType.motivation:
        return 'Motivation';
      case ImageType.nature:
        return 'Nature';
      case ImageType.quotes:
        return 'Quotes';
      case ImageType.abstract:
        return 'Abstract';
      case ImageType.spiritual:
        return 'Spiritual';
      case ImageType.general:
        return 'General';
      case ImageType.unknown:
        return 'Unknown';
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        thumbnailUrl,
        author,
        authorIconUrl,
        categoryId,
        preferenceIds,
        imageType,
        isFeatured,
        isPremium,
        resolutionWidth,
        resolutionHeight,
        fileSizeBytes,
        downloadCount,
        sortOrder,
        metadata,
        createdAt,
        updatedAt,
      ];
}
