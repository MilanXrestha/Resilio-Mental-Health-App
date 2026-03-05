import 'package:equatable/equatable.dart';

import '../../domain/entities/image_entity.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object?> get props => [];
}

class ImageInitial extends ImageState {
  const ImageInitial();
}

class ImageLoading extends ImageState {
  const ImageLoading();
}

class ImageLoaded extends ImageState {
  final List<ImageEntity> images;
  final int totalCount;
  final bool hasReachedMax;

  const ImageLoaded({
    required this.images,
    required this.totalCount,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [images, totalCount, hasReachedMax];
}

class ImageError extends ImageState {
  final String message;

  const ImageError(this.message);

  @override
  List<Object?> get props => [message];
}
