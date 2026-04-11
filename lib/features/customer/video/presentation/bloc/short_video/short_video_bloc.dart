import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositories/video_repository.dart';
import 'short_video_event.dart';
import 'short_video_state.dart';

/// Short Video BLoC - manages short video (reels) state and business logic
@injectable
class ShortVideoBloc extends Bloc<ShortVideoEvent, ShortVideoState> {
  final VideoRepository videoRepository;

  ShortVideoBloc(this.videoRepository) : super(ShortVideoInitial()) {
    on<LoadShortVideos>(_onLoadShortVideos);
    on<LoadMoreShortVideos>(_onLoadMoreShortVideos);
    on<RefreshShortVideos>(_onRefreshShortVideos);
  }

  /// Handle LoadShortVideos event
  Future<void> _onLoadShortVideos(
    LoadShortVideos event,
    Emitter<ShortVideoState> emit,
  ) async {
    try {
      emit(ShortVideoLoading());

      final result = await videoRepository.getShortVideos(
        limit: event.limit,
        offset: event.offset,
        isFeatured: event.isFeatured,
      );

      result.fold(
        (failure) => emit(ShortVideoError(failure.toString())),
        (videos) {
          emit(ShortVideoLoaded(
            videos: videos,
            totalCount: videos.length,
            hasReachedMax: videos.length < event.limit,
            currentOffset: event.offset + videos.length,
          ));
        },
      );
    } catch (e) {
      emit(ShortVideoError(e.toString()));
    }
  }

  /// Handle LoadMoreShortVideos event (pagination)
  Future<void> _onLoadMoreShortVideos(
    LoadMoreShortVideos event,
    Emitter<ShortVideoState> emit,
  ) async {
    try {
      if (state is ShortVideoLoaded) {
        emit(ShortVideoLoadingMore());

        final currentState = state as ShortVideoLoaded;

        final result = await videoRepository.getShortVideos(
          limit: 20,
          offset: event.offset,
        );

        result.fold(
          (failure) => emit(ShortVideoError(failure.toString())),
          (videos) {
            final updatedVideos = [...currentState.videos, ...videos];
            emit(currentState.copyWith(
              videos: updatedVideos,
              totalCount: updatedVideos.length,
              hasReachedMax: videos.length < 20,
              currentOffset: event.offset + videos.length,
            ));
          },
        );
      }
    } catch (e) {
      emit(ShortVideoError(e.toString()));
    }
  }

  /// Handle RefreshShortVideos event
  Future<void> _onRefreshShortVideos(
    RefreshShortVideos event,
    Emitter<ShortVideoState> emit,
  ) async {
    try {
      emit(ShortVideoRefreshing());

      final result = await videoRepository.getShortVideos(
        limit: 20,
        offset: 0,
      );

      result.fold(
        (failure) => emit(ShortVideoError(failure.toString())),
        (videos) {
          emit(ShortVideoLoaded(
            videos: videos,
            totalCount: videos.length,
            hasReachedMax: videos.length < 20,
            currentOffset: videos.length,
          ));
        },
      );
    } catch (e) {
      emit(ShortVideoError(e.toString()));
    }
  }
}
