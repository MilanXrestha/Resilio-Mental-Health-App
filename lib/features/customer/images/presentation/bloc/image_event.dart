import 'package:equatable/equatable.dart';

import '../../domain/entities/image_entity.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeaturedImages extends ImageEvent {
  final int limit;
  final List<String>? preferenceIds;
  final String? imageType;

  const LoadFeaturedImages({
    this.limit = 10,
    this.preferenceIds,
    this.imageType,
  });

  @override
  List<Object?> get props => [limit, preferenceIds, imageType];
}

class LoadImageById extends ImageEvent {
  final String imageId;

  const LoadImageById(this.imageId);

  @override
  List<Object?> get props => [imageId];
}

class ListAllImages extends ImageEvent {
  final int limit;
  final int offset;
  final String? categoryId;
  final bool? isFeatured;
  final bool? isPremium;
  final String? imageType;
  final List<String>? preferenceIds;

  const ListAllImages({
    this.limit = 20,
    this.offset = 0,
    this.categoryId,
    this.isFeatured,
    this.isPremium,
    this.imageType,
    this.preferenceIds,
  });

  @override
  List<Object?> get props => [
        limit,
        offset,
        categoryId,
        isFeatured,
        isPremium,
        imageType,
        preferenceIds,
      ];
}

class GetImagesByType extends ImageEvent {
  final String imageType;
  final int limit;
  final int offset;

  const GetImagesByType({
    required this.imageType,
    this.limit = 20,
    this.offset = 0,
  });

  @override
  List<Object?> get props => [imageType, limit, offset];
}

class RefreshImages extends ImageEvent {
  const RefreshImages();
}
