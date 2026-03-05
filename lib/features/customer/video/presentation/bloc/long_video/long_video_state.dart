import 'package:equatable/equatable.dart';

import '../../../domain/entities/video_entity.dart';

/// Long video state base class
abstract class LongVideoState extends Equatable {
  const LongVideoState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class LongVideoInitial extends LongVideoState {}

/// Loading state
class LongVideoLoading extends LongVideoState {}

/// Loading more videos (pagination)
class LongVideoLoadingMore extends LongVideoState {}

/// Refreshing state
class LongVideoRefreshing extends LongVideoState {}

/// Loaded state with video list
class LongVideoLoaded extends LongVideoState {
  final List<VideoEntity> videos;
  final int totalCount;
  final bool hasReachedMax;
  final int currentOffset;
  final String? categoryId;

  const LongVideoLoaded({
    required this.videos,
    required this.totalCount,
    this.hasReachedMax = false,
    this.currentOffset = 0,
    this.categoryId,
  });

  @override
  List<Object?> get props => [videos, totalCount, hasReachedMax, currentOffset, categoryId];

  LongVideoLoaded copyWith({
    List<VideoEntity>? videos,
    int? totalCount,
    bool? hasReachedMax,
    int? currentOffset,
    String? categoryId,
  }) {
    return LongVideoLoaded(
      videos: videos ?? this.videos,
      totalCount: totalCount ?? this.totalCount,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentOffset: currentOffset ?? this.currentOffset,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}

/// Error state
class LongVideoError extends LongVideoState {
  final String message;

  const LongVideoError(this.message);

  @override
  List<Object?> get props => [message];
}
