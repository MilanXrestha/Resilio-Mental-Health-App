import 'package:Resilio/features/customer/favorites/domain/entities/favorite_entity.dart';

abstract class FavoriteRepository {
  Future<List<FavoriteEntity>> getFavorites(String userId);
  Future<bool> addFavorite({
    required String userId,
    required String contentId,
    required FavoriteType contentType,
  });
  Future<bool> removeFavorite({
    required String userId,
    required String contentId,
    required FavoriteType contentType,
  });
  Future<bool> isFavorited({
    required String userId,
    required String contentId,
    required FavoriteType contentType,
  });
}
