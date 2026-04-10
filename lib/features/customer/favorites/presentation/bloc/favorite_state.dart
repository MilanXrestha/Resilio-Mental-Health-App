import 'package:equatable/equatable.dart';
import 'package:Resilio/features/customer/favorites/domain/entities/favorite_entity.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {
  final List<FavoriteEntity> favorites;
  final Map<String, bool> favoriteStatusMap; // contentId -> isFavorited

  const FavoritesLoaded({
    required this.favorites,
    required this.favoriteStatusMap,
  });

  @override
  List<Object?> get props => [favorites, favoriteStatusMap];

  FavoritesLoaded copyWith({
    List<FavoriteEntity>? favorites,
    Map<String, bool>? favoriteStatusMap,
  }) {
    return FavoritesLoaded(
      favorites: favorites ?? this.favorites,
      favoriteStatusMap: favoriteStatusMap ?? this.favoriteStatusMap,
    );
  }
}

class FavoriteError extends FavoriteState {
  final String message;
  const FavoriteError(this.message);

  @override
  List<Object?> get props => [message];
}
