part of 'explore_bloc.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object?> get props => [];
}

class ExploreInitial extends ExploreState {
  const ExploreInitial();
}

class ExploreLoading extends ExploreState {
  const ExploreLoading();
}

class ExploreLoaded extends ExploreState {
  final List<ExploreItemEntity> allItems;
  final List<ExploreItemEntity> filteredItems;
  final ExploreFilter filter;
  final List<String> recentSearches;
  final List<String> trendingSearches;
  final bool isSearching;

  const ExploreLoaded({
    required this.allItems,
    required this.filteredItems,
    required this.filter,
    this.recentSearches = const [],
    this.trendingSearches = const [],
    this.isSearching = false,
  });

  /// Get items grouped by type for section display
  Map<ExploreItemType, List<ExploreItemEntity>> get itemsByType {
    final grouped = <ExploreItemType, List<ExploreItemEntity>>{};
    for (final item in filteredItems) {
      grouped.putIfAbsent(item.type, () => []).add(item);
    }
    return grouped;
  }

  /// Check if there are results
  bool get hasResults => filteredItems.isNotEmpty;

  /// Check if search is active
  bool get isSearchActive =>
      filter.searchQuery != null && filter.searchQuery!.isNotEmpty;

  ExploreLoaded copyWith({
    List<ExploreItemEntity>? allItems,
    List<ExploreItemEntity>? filteredItems,
    ExploreFilter? filter,
    List<String>? recentSearches,
    List<String>? trendingSearches,
    bool? isSearching,
  }) {
    return ExploreLoaded(
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      filter: filter ?? this.filter,
      recentSearches: recentSearches ?? this.recentSearches,
      trendingSearches: trendingSearches ?? this.trendingSearches,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [
    allItems,
    filteredItems,
    filter,
    recentSearches,
    trendingSearches,
    isSearching,
  ];
}

class ExploreError extends ExploreState {
  final String message;

  const ExploreError(this.message);

  @override
  List<Object?> get props => [message];
}