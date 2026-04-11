import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/explore_item_entity.dart';

abstract class ExploreRepository {
  /// Fetches all explore items from various sources
  Future<Either<Failure, List<ExploreItemEntity>>> getAllExploreItems();

  /// Fetches explore items by type
  Future<Either<Failure, List<ExploreItemEntity>>> getExploreItemsByType(
      ExploreItemType type, {
        int limit = 20,
        int offset = 0,
      });

  /// Gets recent searches from local storage
  Future<List<String>> getRecentSearches();

  /// Saves a search query to recent searches
  Future<void> saveRecentSearch(String query);

  /// Clears recent searches
  Future<void> clearRecentSearches();

  /// Fetches all explore items that belong to a specific category
  Future<Either<Failure, List<ExploreItemEntity>>> getExploreItemsByCategory(
      String categoryId);

  /// Gets popular/trending searches (can be static or from backend)
  Future<List<String>> getTrendingSearches();
}