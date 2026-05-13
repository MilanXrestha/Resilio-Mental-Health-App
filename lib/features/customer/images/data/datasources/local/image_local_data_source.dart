import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../../../../../core/database/database_helper.dart';
import '../../../domain/entities/image_entity.dart';

abstract class ImageLocalDataSource {
  Future<void> cacheImages(List<ImageEntity> images);
  Future<List<ImageEntity>> getCachedImages();
  Future<void> clearCache();
}

@LazySingleton(as: ImageLocalDataSource)
class ImageLocalDataSourceImpl implements ImageLocalDataSource {
  final DatabaseHelper _databaseHelper;
  static const String _keyImages = 'dashboard_images';

  ImageLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> cacheImages(List<ImageEntity> images) async {
    final existingImages = await getCachedImages();
    final merged = <String, ImageEntity>{
      for (final image in existingImages) image.id: image,
      for (final image in images) image.id: image,
    };

    final data = merged.values
        .map(
          (img) => {
            'id': img.id,
            'title': img.title,
            'description': img.description,
            'imageUrl': img.imageUrl,
            'thumbnailUrl': img.thumbnailUrl,
            'author': img.author,
            'authorIconUrl': img.authorIconUrl,
            'categoryId': img.categoryId,
            'preferenceIds': img.preferenceIds,
            'imageType': img.imageType.index, // Store as index for enum
            'isFeatured': img.isFeatured,
            'isPremium': img.isPremium,
            'resolutionWidth': img.resolutionWidth,
            'resolutionHeight': img.resolutionHeight,
            'fileSizeBytes': img.fileSizeBytes,
            'downloadCount': img.downloadCount,
            'sortOrder': img.sortOrder,
            'metadata': img.metadata,
            'createdAt': img.createdAt.toIso8601String(),
            'updatedAt': img.updatedAt.toIso8601String(),
          },
        )
        .toList();
    await _databaseHelper.saveToCache(
      _keyImages,
      utf8.encode(jsonEncode(data)),
    );
  }

  @override
  Future<List<ImageEntity>> getCachedImages() async {
    final bytes = await _databaseHelper.getFromCache(_keyImages);
    if (bytes != null) {
      try {
        final List<dynamic> data = jsonDecode(utf8.decode(bytes));
        return data
            .map(
              (img) => ImageEntity(
                id: img['id'] ?? '',
                title: img['title'] ?? '',
                description: img['description'] ?? '',
                imageUrl: img['imageUrl'] ?? '',
                thumbnailUrl: img['thumbnailUrl'] ?? '',
                author: img['author'] ?? '',
                authorIconUrl: img['authorIconUrl'] ?? '',
                categoryId: img['categoryId'] ?? '',
                preferenceIds: List<String>.from(img['preferenceIds'] ?? []),
                imageType: _parseImageType(img['imageType']),
                isFeatured: img['isFeatured'] ?? false,
                isPremium: img['isPremium'] ?? false,
                resolutionWidth: img['resolutionWidth'] ?? 0,
                resolutionHeight: img['resolutionHeight'] ?? 0,
                fileSizeBytes: img['fileSizeBytes'] ?? 0,
                downloadCount: img['downloadCount'] ?? 0,
                sortOrder: img['sortOrder'] ?? 0,
                metadata: img['metadata'] ?? '{}',
                createdAt: DateTime.parse(
                  img['createdAt'] ?? DateTime.now().toIso8601String(),
                ),
                updatedAt: DateTime.parse(
                  img['updatedAt'] ?? DateTime.now().toIso8601String(),
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

  ImageType _parseImageType(dynamic value) {
    if (value is int && value >= 0 && value < ImageType.values.length) {
      return ImageType.values[value];
    }
    if (value is String) {
      return ImageType.values.firstWhere(
        (type) => type.name == value || type.toString() == value,
        orElse: () => ImageType.general,
      );
    }
    return ImageType.general;
  }
}
