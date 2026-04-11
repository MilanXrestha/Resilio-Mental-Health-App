import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/entities/explore_item_entity.dart';
import '../../domain/repositories/explore_repository.dart';
import '../../domain/usecases/explore_usecases.dart';

part 'explore_event.dart';
part 'explore_state.dart';

@injectable
class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetAllExploreItems _getAllExploreItems;
  final SearchExploreItems _searchExploreItems;
  final ManageRecentSearches _manageRecentSearches;
  final ExploreRepository _exploreRepository;

  ExploreBloc(
      this._getAllExploreItems,
      this._searchExploreItems,
      this._manageRecentSearches,
      this._exploreRepository,
      ) : super(const ExploreInitial()) {
    on<LoadExploreItems>(_onLoadExploreItems);
    on<LoadExploreItemsForCategory>(_onLoadExploreItemsForCategory);
    on<LoadExploreItemsByType>(_onLoadExploreItemsByType);
    on<RefreshExploreItems>(_onRefreshExploreItems);
    on<UpdateSearchQuery>(
      _onUpdateSearchQuery,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<SubmitSearch>(_onSubmitSearch);
    on<ClearSearch>(_onClearSearch);
    on<UpdateFilters>(_onUpdateFilters);
    on<ClearFilters>(_onClearFilters);
    on<ToggleTypeFilter>(_onToggleTypeFilter);
    on<LoadRecentSearches>(_onLoadRecentSearches);
    on<ClearRecentSearches>(_onClearRecentSearches);
    on<SelectSuggestedSearch>(_onSelectSuggestedSearch);
  }

  /// Debounce transformer for search
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _onLoadExploreItems(
      LoadExploreItems event,
      Emitter<ExploreState> emit,
      ) async {
    emit(const ExploreLoading());

    final result = await _getAllExploreItems();
    final recentSearches = await _manageRecentSearches.getRecentSearches();
    final trendingSearches = await _manageRecentSearches.getTrendingSearches();

    result.fold(
          (failure) => emit(ExploreError(failure.message)),
          (items) => emit(ExploreLoaded(
        allItems: items,
        filteredItems: items,
        filter: const ExploreFilter(),
        recentSearches: recentSearches,
        trendingSearches: trendingSearches,
      )),
    );
  }

  Future<void> _onLoadExploreItemsForCategory(
      LoadExploreItemsForCategory event,
      Emitter<ExploreState> emit,
      ) async {
    emit(const ExploreLoading());

    final result =
        await _exploreRepository.getExploreItemsByCategory(event.categoryId);

    result.fold(
      (failure) => emit(ExploreError(failure.message)),
      (items) => emit(ExploreLoaded(
        allItems: items,
        filteredItems: items,
        filter: const ExploreFilter(),
      )),
    );
  }

  Future<void> _onLoadExploreItemsByType(
      LoadExploreItemsByType event,
      Emitter<ExploreState> emit,
      ) async {
    emit(const ExploreLoading());

    final result = await _exploreRepository.getExploreItemsByType(
      event.contentType,
      limit: 200,
    );

    result.fold(
      (failure) => emit(ExploreError(failure.message)),
      (items) => emit(ExploreLoaded(
        allItems: items,
        filteredItems: items,
        filter: const ExploreFilter(),
      )),
    );
  }

  Future<void> _onRefreshExploreItems(
      RefreshExploreItems event,
      Emitter<ExploreState> emit,
      ) async {
    final currentState = state;
    ExploreFilter currentFilter = const ExploreFilter();

    if (currentState is ExploreLoaded) {
      currentFilter = currentState.filter;
    }

    final result = await _getAllExploreItems();
    final recentSearches = await _manageRecentSearches.getRecentSearches();
    final trendingSearches = await _manageRecentSearches.getTrendingSearches();

    await result.fold(
          (failure) async => emit(ExploreError(failure.message)),
          (items) async {
        final filteredItems = await _searchExploreItems(
          items: items,
          filter: currentFilter,
        );
        emit(ExploreLoaded(
          allItems: items,
          filteredItems: filteredItems,
          filter: currentFilter,
          recentSearches: recentSearches,
          trendingSearches: trendingSearches,
        ));
      },
    );
  }

  Future<void> _onUpdateSearchQuery(
      UpdateSearchQuery event,
      Emitter<ExploreState> emit,
      ) async {
    final currentState = state;
    if (currentState is! ExploreLoaded) return;

    final newFilter = currentState.filter.copyWith(searchQuery: event.query);

    final filteredItems = await _searchExploreItems(
      items: currentState.allItems,
      filter: newFilter,
    );

    emit(currentState.copyWith(
      filteredItems: filteredItems,
      filter: newFilter,
      isSearching: event.query.isNotEmpty,
    ));
  }

  Future<void> _onSubmitSearch(
      SubmitSearch event,
      Emitter<ExploreState> emit,
      ) async {
    if (event.query.trim().isEmpty) return;

    await _manageRecentSearches.saveSearch(event.query);

    final currentState = state;
    if (currentState is ExploreLoaded) {
      final recentSearches = await _manageRecentSearches.getRecentSearches();
      emit(currentState.copyWith(recentSearches: recentSearches));
    }
  }

  Future<void> _onClearSearch(
      ClearSearch event,
      Emitter<ExploreState> emit,
      ) async {
    final currentState = state;
    if (currentState is! ExploreLoaded) return;

    final newFilter = currentState.filter.copyWith(searchQuery: '');

    final filteredItems = await _searchExploreItems(
      items: currentState.allItems,
      filter: newFilter,
    );

    emit(currentState.copyWith(
      filteredItems: filteredItems,
      filter: newFilter,
      isSearching: false,
    ));
  }

  Future<void> _onUpdateFilters(
      UpdateFilters event,
      Emitter<ExploreState> emit,
      ) async {
    final currentState = state;
    if (currentState is! ExploreLoaded) return;

    final filteredItems = await _searchExploreItems(
      items: currentState.allItems,
      filter: event.filter,
    );

    emit(currentState.copyWith(
      filteredItems: filteredItems,
      filter: event.filter,
    ));
  }

  Future<void> _onClearFilters(
      ClearFilters event,
      Emitter<ExploreState> emit,
      ) async {
    final currentState = state;
    if (currentState is! ExploreLoaded) return;

    final newFilter = currentState.filter.clearFilters();

    final filteredItems = await _searchExploreItems(
      items: currentState.allItems,
      filter: newFilter,
    );

    emit(currentState.copyWith(
      filteredItems: filteredItems,
      filter: newFilter,
    ));
  }

  Future<void> _onToggleTypeFilter(
      ToggleTypeFilter event,
      Emitter<ExploreState> emit,
      ) async {
    final currentState = state;
    if (currentState is! ExploreLoaded) return;

    final currentTypes = List<ExploreItemType>.from(currentState.filter.types);

    if (currentTypes.contains(event.type)) {
      currentTypes.remove(event.type);
    } else {
      currentTypes.add(event.type);
    }

    final newFilter = currentState.filter.copyWith(types: currentTypes);

    final filteredItems = await _searchExploreItems(
      items: currentState.allItems,
      filter: newFilter,
    );

    emit(currentState.copyWith(
      filteredItems: filteredItems,
      filter: newFilter,
    ));
  }

  Future<void> _onLoadRecentSearches(
      LoadRecentSearches event,
      Emitter<ExploreState> emit,
      ) async {
    final currentState = state;
    if (currentState is! ExploreLoaded) return;

    final recentSearches = await _manageRecentSearches.getRecentSearches();
    emit(currentState.copyWith(recentSearches: recentSearches));
  }

  Future<void> _onClearRecentSearches(
      ClearRecentSearches event,
      Emitter<ExploreState> emit,
      ) async {
    await _manageRecentSearches.clearSearches();

    final currentState = state;
    if (currentState is ExploreLoaded) {
      emit(currentState.copyWith(recentSearches: []));
    }
  }

  Future<void> _onSelectSuggestedSearch(
      SelectSuggestedSearch event,
      Emitter<ExploreState> emit,
      ) async {
    add(UpdateSearchQuery(event.query));
    add(SubmitSearch(event.query));
  }
}