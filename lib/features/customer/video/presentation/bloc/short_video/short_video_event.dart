import 'package:equatable/equatable.dart';

/// Short video event base class
abstract class ShortVideoEvent extends Equatable {
  const ShortVideoEvent();

  @override
  List<Object?> get props => [];
}

/// Load short videos (reels)
class LoadShortVideos extends ShortVideoEvent {
  final int limit;
  final int offset;
  final bool? isFeatured;

  const LoadShortVideos({this.limit = 20, this.offset = 0, this.isFeatured});

  @override
  List<Object?> get props => [limit, offset, isFeatured];
}

/// Load more short videos (pagination)
class LoadMoreShortVideos extends ShortVideoEvent {
  final int offset;

  const LoadMoreShortVideos({this.offset = 0});

  @override
  List<Object?> get props => [offset];
}

/// Refresh short videos
class RefreshShortVideos extends ShortVideoEvent {}
