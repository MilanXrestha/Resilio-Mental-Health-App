import 'package:injectable/injectable.dart';
import 'package:Resilio/features/customer/favorites/data/datasources/favorite_remote_datasource.dart';
import 'package:Resilio/features/customer/favorites/domain/entities/favorite_entity.dart';
import 'package:Resilio/features/customer/favorites/domain/repositories/favorite_repository.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource _remoteDataSource;

  FavoriteRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<FavoriteEntity>> getFavorites(String userId) async {
    try {
      final favorites = await _remoteDataSource.getFavorites(userId);
      return favorites.map(_mapToEntity).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> addFavorite({
    required String userId,
    required String contentId,
    required FavoriteType contentType,
  }) async {
    try {
      return await _remoteDataSource.addFavorite(
        userId: userId,
        contentId: contentId,
        contentType: contentType.value,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> removeFavorite({
    required String userId,
    required String contentId,
    required FavoriteType contentType,
  }) async {
    try {
      return await _remoteDataSource.removeFavorite(
        userId: userId,
        contentId: contentId,
        contentType: contentType.value,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isFavorited({
    required String userId,
    required String contentId,
    required FavoriteType contentType,
  }) async {
    try {
      return await _remoteDataSource.isFavorited(
        userId: userId,
        contentId: contentId,
        contentType: contentType.value,
      );
    } catch (e) {
      return false;
    }
  }

  FavoriteEntity _mapToEntity(Map<String, dynamic> json) {
    return FavoriteEntity(
      id: json['id'],
      userId: json['user_id'],
      contentId: json['content_id'],
      contentType: FavoriteTypeExtension.fromString(json['content_type']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
