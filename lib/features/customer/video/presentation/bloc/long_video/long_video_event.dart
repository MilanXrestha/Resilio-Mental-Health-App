import 'package:equatable/equatable.dart';

/// Long video event base class
abstract class LongVideoEvent extends Equatable {
  const LongVideoEvent();

  @override
  List<Object?> get props => [];
}

/// Load long videos (therapy sessions)
class LoadLongVideos extends LongVideoEvent {
  final String? categoryId;
  final int limit;
  final int offset;
  final bool? isFeatured;

  const LoadLongVideos({this.categoryId, this.limit = 20, this.offset = 0, this.isFeatured});

  @override
  List<Object?> get props => [categoryId, limit, offset, isFeatured];
}

/// Load more long videos (pagination)
class LoadMoreLongVideos extends LongVideoEvent {
  final String? categoryId;
  final int offset;

  const LoadMoreLongVideos({this.categoryId, this.offset = 0});

  @override
  List<Object?> get props => [categoryId, offset];
}

/// Refresh long videos
class RefreshLongVideos extends LongVideoEvent {}
