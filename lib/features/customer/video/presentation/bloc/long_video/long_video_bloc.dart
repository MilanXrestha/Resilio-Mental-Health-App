import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositories/video_repository.dart';
import 'long_video_event.dart';
import 'long_video_state.dart';

/// Long Video BLoC - manages long video (therapy sessions) state and business logic
@injectable
class LongVideoBloc extends Bloc<LongVideoEvent, LongVideoState> {
  final VideoRepository videoRepository;

  LongVideoBloc(this.videoRepository) : super(LongVideoInitial()) {
    on<LoadLongVideos>(_onLoadLongVideos);
    on<LoadMoreLongVideos>(_onLoadMoreLongVideos);
    on<RefreshLongVideos>(_onRefreshLongVideos);
  }

  /// Handle LoadLongVideos event
  Future<void> _onLoadLongVideos(
    LoadLongVideos event,
    Emitter<LongVideoState> emit,
  ) async {
    try {
      emit(LongVideoLoading());

      final result = await videoRepository.getLongVideos(
        categoryId: event.categoryId,
        limit: event.limit,
        offset: event.offset,
      );

      result.fold(
        (failure) => emit(LongVideoError(failure.toString())),
        (videos) {
          emit(LongVideoLoaded(
            videos: videos,
            totalCount: videos.length,
            hasReachedMax: videos.length < event.limit,
            currentOffset: event.offset + videos.length,
            categoryId: event.categoryId,
          ));
        },
      );
    } catch (e) {
      emit(LongVideoError(e.toString()));
    }
  }

  /// Handle LoadMoreLongVideos event (pagination)
  Future<void> _onLoadMoreLongVideos(
    LoadMoreLongVideos event,
    Emitter<LongVideoState> emit,
  ) async {
    try {
      if (state is LongVideoLoaded) {
        emit(LongVideoLoadingMore());

        final currentState = state as LongVideoLoaded;

        final result = await videoRepository.getLongVideos(
          categoryId: event.categoryId ?? currentState.categoryId,
          limit: 20,
          offset: event.offset,
        );

        result.fold(
          (failure) => emit(LongVideoError(failure.toString())),
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
      emit(LongVideoError(e.toString()));
    }
  }

  /// Handle RefreshLongVideos event
  Future<void> _onRefreshLongVideos(
    RefreshLongVideos event,
    Emitter<LongVideoState> emit,
  ) async {
    try {
      emit(LongVideoRefreshing());

      final currentState = state is LongVideoLoaded ? state as LongVideoLoaded : null;

      final result = await videoRepository.getLongVideos(
        categoryId: currentState?.categoryId,
        limit: 20,
        offset: 0,
      );

      result.fold(
        (failure) => emit(LongVideoError(failure.toString())),
        (videos) {
          emit(LongVideoLoaded(
            videos: videos,
            totalCount: videos.length,
            hasReachedMax: videos.length < 20,
            currentOffset: videos.length,
            categoryId: currentState?.categoryId,
          ));
        },
      );
    } catch (e) {
      emit(LongVideoError(e.toString()));
    }
  }
}
