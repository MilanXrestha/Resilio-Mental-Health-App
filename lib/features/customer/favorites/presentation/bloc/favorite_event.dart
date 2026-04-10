import 'package:equatable/equatable.dart';
import 'package:Resilio/features/customer/favorites/domain/entities/favorite_entity.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoriteEvent {
  final String userId;
  const LoadFavorites(this.userId);

  @override
  List<Object?> get props => [userId];
}

class ToggleFavorite extends FavoriteEvent {
  final String userId;
  final String contentId;
  final FavoriteType contentType;
  
  const ToggleFavorite({
    required this.userId,
    required this.contentId,
    required this.contentType,
  });

  @override
  List<Object?> get props => [userId, contentId, contentType];
}

class CheckFavoriteStatus extends FavoriteEvent {
  final String userId;
  final String contentId;
  final FavoriteType contentType;

  const CheckFavoriteStatus({
    required this.userId,
    required this.contentId,
    required this.contentType,
  });

  @override
  List<Object?> get props => [userId, contentId, contentType];
}

/// Clears local favorite state (e.g. on logout).
class FavoriteReset extends FavoriteEvent {
  const FavoriteReset();
}
