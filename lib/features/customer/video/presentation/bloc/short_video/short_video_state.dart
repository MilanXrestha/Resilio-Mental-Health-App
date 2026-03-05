import 'package:equatable/equatable.dart';

import '../../../domain/entities/video_entity.dart';

/// Short video state base class
abstract class ShortVideoState extends Equatable {
  const ShortVideoState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ShortVideoInitial extends ShortVideoState {}

/// Loading state
class ShortVideoLoading extends ShortVideoState {}

/// Loading more videos (pagination)
class ShortVideoLoadingMore extends ShortVideoState {}

/// Refreshing state
class ShortVideoRefreshing extends ShortVideoState {}

/// Loaded state with video list
class ShortVideoLoaded extends ShortVideoState {
  final List<VideoEntity> videos;
  final int totalCount;
  final bool hasReachedMax;
  final int currentOffset;

  const ShortVideoLoaded({
    required this.videos,
    required this.totalCount,
    this.hasReachedMax = false,
    this.currentOffset = 0,
  });

  @override
  List<Object?> get props => [videos, totalCount, hasReachedMax, currentOffset];

  ShortVideoLoaded copyWith({
    List<VideoEntity>? videos,
    int? totalCount,
    bool? hasReachedMax,
    int? currentOffset,
  }) {
    return ShortVideoLoaded(
      videos: videos ?? this.videos,
      totalCount: totalCount ?? this.totalCount,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }
}

/// Error state
class ShortVideoError extends ShortVideoState {
  final String message;

  const ShortVideoError(this.message);

  @override
  List<Object?> get props => [message];
}
