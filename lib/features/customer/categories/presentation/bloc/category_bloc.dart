import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_categories_usecase.dart';
import 'category_event.dart';
import 'category_state.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;

  CategoryBloc(this._getCategoriesUseCase) : super(const CategoryInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryLoading());

    final result = await _getCategoriesUseCase.call();

    result.fold(
      (failure) => emit(CategoryError(failure.message ?? 'Failed to load categories')),
      (categories) => emit(CategoryLoaded(categories)),
    );
  }
}
