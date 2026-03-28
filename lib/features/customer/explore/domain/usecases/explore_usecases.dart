import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/explore_item_entity.dart';
import '../repositories/explore_repository.dart';

/// Use case for getting all explore items
@lazySingleton
class GetAllExploreItems {
  final ExploreRepository _repository;

  GetAllExploreItems(this._repository);

  Future<Either<Failure, List<ExploreItemEntity>>> call() async {
    return await _repository.getAllExploreItems();
  }
}

/// Use case for searching and filtering explore items (client-side)
@lazySingleton
class SearchExploreItems {
  Future<List<ExploreItemEntity>> call({
    required List<ExploreItemEntity> items,
    required ExploreFilter filter,
  }) async {
    var filteredItems = items.where((item) {
      return item.matchesFilters(
        types: filter.types.isEmpty ? null : filter.types,
        categoryIds: filter.categoryIds.isEmpty ? null : filter.categoryIds,
        isFeaturedOnly: filter.isFeaturedOnly,
        isPremiumOnly: filter.isPremiumOnly,
        minDuration: filter.minDuration,
        maxDuration: filter.maxDuration,
      );
    }).toList();

    // Apply search query
    final query = filter.searchQuery?.trim() ?? '';
    if (query.isNotEmpty) {
      filteredItems = filteredItems
          .where((item) => item.searchScore(query) > 0)
          .toList();

      // Sort by relevance if searching
      if (filter.sortBy == ExploreSortBy.relevance) {
        filteredItems.sort((a, b) {
          return b.searchScore(query).compareTo(a.searchScore(query));
        });
        return filteredItems;
      }
    }

    // Apply sorting
    switch (filter.sortBy) {
      case ExploreSortBy.relevance:
      // If no search query, sort by featured then newest
        filteredItems.sort((a, b) {
          if (a.isFeatured != b.isFeatured) {
            return a.isFeatured ? -1 : 1;
          }
          return b.createdAt.compareTo(a.createdAt);
        });
        break;
      case ExploreSortBy.newest:
        filteredItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case ExploreSortBy.oldest:
        filteredItems.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case ExploreSortBy.title:
        filteredItems.sort((a, b) => a.title.compareTo(b.title));
        break;
      case ExploreSortBy.duration:
        filteredItems.sort((a, b) {
          final aDuration = a.durationSeconds ?? 0;
          final bDuration = b.durationSeconds ?? 0;
          return bDuration.compareTo(aDuration);
        });
        break;
    }

    if (!filter.sortDescending && filter.sortBy != ExploreSortBy.relevance) {
      filteredItems = filteredItems.reversed.toList();
    }

    return filteredItems;
  }
}

/// Use case for managing recent searches
@lazySingleton
class ManageRecentSearches {
  final ExploreRepository _repository;

  ManageRecentSearches(this._repository);

  Future<List<String>> getRecentSearches() async {
    return await _repository.getRecentSearches();
  }

  Future<void> saveSearch(String query) async {
    if (query.trim().isNotEmpty) {
      await _repository.saveRecentSearch(query.trim());
    }
  }

  Future<void> clearSearches() async {
    await _repository.clearRecentSearches();
  }

  Future<List<String>> getTrendingSearches() async {
    return await _repository.getTrendingSearches();
  }
}