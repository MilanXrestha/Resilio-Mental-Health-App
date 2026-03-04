part of 'main_screen_cubit.dart';

class MainScreenState extends Equatable {
  final int selectedIndex;
  final bool isNavBarVisible;
  final bool isSearchActive;
  final dynamic selectedCategory;

  const MainScreenState({
    this.selectedIndex = 0,
    this.isNavBarVisible = true,
    this.isSearchActive = false,
    this.selectedCategory,
  });

  MainScreenState copyWith({
    int? selectedIndex,
    bool? isNavBarVisible,
    bool? isSearchActive,
    dynamic selectedCategory,
  }) {
    return MainScreenState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isNavBarVisible: isNavBarVisible ?? this.isNavBarVisible,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, isNavBarVisible, isSearchActive, selectedCategory];
}
