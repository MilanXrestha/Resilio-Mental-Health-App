import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:Resilio/features/customer/favorites/domain/repositories/favorite_repository.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

@injectable
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository _repository;

  FavoriteBloc(this._repository) : super(FavoriteInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
    on<CheckFavoriteStatus>(_onCheckFavoriteStatus);
    on<FavoriteReset>((_, emit) => emit(FavoriteInitial()));
  }

  Future<void> _onLoadFavorites(LoadFavorites event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    try {
      final favorites = await _repository.getFavorites(event.userId);
      final statusMap = <String, bool>{};
      for (var f in favorites) {
        statusMap[f.contentId] = true;
      }
      emit(FavoritesLoaded(favorites: favorites, favoriteStatusMap: statusMap));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<FavoriteState> emit) async {
    final currentState = state;
    FavoritesLoaded loadedState;

    if (currentState is FavoritesLoaded) {
      loadedState = currentState;
    } else {
      // If not loaded, we assume false for this item and initialize an empty map
      loadedState = const FavoritesLoaded(favorites: [], favoriteStatusMap: {});
    }

    final isCurrentlyFavorited = loadedState.favoriteStatusMap[event.contentId] ?? false;
    
    // Optimistic update
    final newStatusMap = Map<String, bool>.from(loadedState.favoriteStatusMap);
    newStatusMap[event.contentId] = !isCurrentlyFavorited;
    emit(loadedState.copyWith(favoriteStatusMap: newStatusMap));

    try {
      if (isCurrentlyFavorited) {
        await _repository.removeFavorite(
          userId: event.userId,
          contentId: event.contentId,
          contentType: event.contentType,
        );
      } else {
        await _repository.addFavorite(
          userId: event.userId,
          contentId: event.contentId,
          contentType: event.contentType,
        );
      }
      
      // We don't necessarily need to reload everything here as the map is synced
      // But if we want the full entity list for the FavoriteScreen, we could trigger a reload
      // _onLoadFavorites(LoadFavorites(event.userId), emit);
    } catch (e) {
      // Rollback on error
      final rollbackMap = Map<String, bool>.from(loadedState.favoriteStatusMap);
      rollbackMap[event.contentId] = isCurrentlyFavorited;
      emit(loadedState.copyWith(favoriteStatusMap: rollbackMap));
    }
  }

  Future<void> _onCheckFavoriteStatus(CheckFavoriteStatus event, Emitter<FavoriteState> emit) async {
    try {
      final isFavorited = await _repository.isFavorited(
        userId: event.userId,
        contentId: event.contentId,
        contentType: event.contentType,
      );
      
      if (state is FavoritesLoaded) {
        final currentState = state as FavoritesLoaded;
        final newMap = Map<String, bool>.from(currentState.favoriteStatusMap);
        newMap[event.contentId] = isFavorited;
        emit(currentState.copyWith(favoriteStatusMap: newMap));
      } else {
        emit(FavoritesLoaded(
          favorites: const [],
          favoriteStatusMap: {event.contentId: isFavorited},
        ));
      }
    } catch (e) {
      // Ignore errors for single status checks
    }
  }
}
