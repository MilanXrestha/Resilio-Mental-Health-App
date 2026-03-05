import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/image_entity.dart';
import '../../domain/repositories/image_repository.dart';
import 'image_event.dart';
import 'image_state.dart';

@injectable
class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository imageRepository;

  ImageBloc(this.imageRepository) : super(const ImageInitial()) {
    on<LoadFeaturedImages>(_onLoadFeaturedImages);
    on<LoadImageById>(_onLoadImageById);
    on<ListAllImages>(_onListAllImages);
    on<GetImagesByType>(_onGetImagesByType);
    on<RefreshImages>(_onRefreshImages);
  }

  Future<void> _onLoadFeaturedImages(
    LoadFeaturedImages event,
    Emitter<ImageState> emit,
  ) async {
    try {
      emit(const ImageLoading());
      
      final result = await imageRepository.getFeaturedImages(
        limit: event.limit,
        preferenceIds: event.preferenceIds,
        imageType: event.imageType,
      );

      result.fold(
        (failure) => emit(ImageError(failure.toString())),
        (images) {
          emit(ImageLoaded(
            images: images,
            totalCount: images.length,
            hasReachedMax: images.length < event.limit,
          ));
        },
      );
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }

  Future<void> _onLoadImageById(
    LoadImageById event,
    Emitter<ImageState> emit,
  ) async {
    try {
      emit(const ImageLoading());
      
      final result = await imageRepository.getImageById(event.imageId);

      result.fold(
        (failure) => emit(ImageError(failure.toString())),
        (image) {
          emit(ImageLoaded(
            images: [image],
            totalCount: 1,
            hasReachedMax: true,
          ));
        },
      );
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }

  Future<void> _onListAllImages(
    ListAllImages event,
    Emitter<ImageState> emit,
  ) async {
    try {
      emit(const ImageLoading());
      
      final result = await imageRepository.listImages(
        limit: event.limit,
        offset: event.offset,
        categoryId: event.categoryId,
        isFeatured: event.isFeatured,
        isPremium: event.isPremium,
        imageType: event.imageType,
        preferenceIds: event.preferenceIds,
      );

      result.fold(
        (failure) => emit(ImageError(failure.toString())),
        (listResult) {
          final currentState = state;
          List<ImageEntity> currentImages = [];
          
          if (currentState is ImageLoaded) {
            currentImages = currentState.images;
          }

          // If offset is 0, replace the list; otherwise, append
          final updatedList = event.offset == 0
              ? listResult.images
              : [...currentImages, ...listResult.images];

          emit(ImageLoaded(
            images: updatedList,
            totalCount: listResult.totalCount,
            hasReachedMax: updatedList.length >= listResult.totalCount,
          ));
        },
      );
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }

  Future<void> _onGetImagesByType(
    GetImagesByType event,
    Emitter<ImageState> emit,
  ) async {
    try {
      emit(const ImageLoading());
      
      final result = await imageRepository.getImagesByType(
        imageType: event.imageType,
        limit: event.limit,
        offset: event.offset,
      );

      result.fold(
        (failure) => emit(ImageError(failure.toString())),
        (listResult) {
          emit(ImageLoaded(
            images: listResult.images,
            totalCount: listResult.totalCount,
            hasReachedMax: listResult.images.length >= listResult.totalCount,
          ));
        },
      );
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }

  Future<void> _onRefreshImages(
    RefreshImages event,
    Emitter<ImageState> emit,
  ) async {
    // Re-trigger the last event or load featured images
    add(const LoadFeaturedImages(limit: 10));
  }
}
