part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object?> get props => [];
}

/// Load all explore items
class LoadExploreItems extends ExploreEvent {
  const LoadExploreItems();
}

/// Refresh explore items
class RefreshExploreItems extends ExploreEvent {
  const RefreshExploreItems();
}

/// Update search query
class UpdateSearchQuery extends ExploreEvent {
  final String query;

  const UpdateSearchQuery(this.query);

  @override
  List<Object?> get props => [query];
}

/// Submit search (saves to recent searches)
class SubmitSearch extends ExploreEvent {
  final String query;

  const SubmitSearch(this.query);

  @override
  List<Object?> get props => [query];
}

/// Clear search query
class ClearSearch extends ExploreEvent {
  const ClearSearch();
}

/// Update filters
class UpdateFilters extends ExploreEvent {
  final ExploreFilter filter;

  const UpdateFilters(this.filter);

  @override
  List<Object?> get props => [filter];
}

/// Clear all filters
class ClearFilters extends ExploreEvent {
  const ClearFilters();
}

/// Toggle type filter
class ToggleTypeFilter extends ExploreEvent {
  final ExploreItemType type;

  const ToggleTypeFilter(this.type);

  @override
  List<Object?> get props => [type];
}

/// Load recent searches
class LoadRecentSearches extends ExploreEvent {
  const LoadRecentSearches();
}

/// Clear recent searches
class ClearRecentSearches extends ExploreEvent {
  const ClearRecentSearches();
}

/// Select recent/trending search
class SelectSuggestedSearch extends ExploreEvent {
  final String query;

  const SelectSuggestedSearch(this.query);

  @override
  List<Object?> get props => [query];
}