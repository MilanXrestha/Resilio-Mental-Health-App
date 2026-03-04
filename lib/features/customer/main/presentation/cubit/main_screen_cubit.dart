import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'main_screen_state.dart';

@injectable
class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(const MainScreenState());

  void changeTab(int index) {
    if (index == state.selectedIndex) return;
    
    emit(state.copyWith(selectedIndex: index));
  }

  void setNavBarVisibility(bool isVisible) {
    emit(state.copyWith(isNavBarVisible: isVisible));
  }

  void updateSelectedCategory(dynamic category) {
    emit(state.copyWith(selectedCategory: category));
  }

  void setSearchActive(bool isActive) {
    emit(state.copyWith(isSearchActive: isActive));
  }

  void resetToHome() {
    emit(const MainScreenState());
  }
}
