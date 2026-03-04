import 'package:equatable/equatable.dart';

import '../../domain/entities/category_entity.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

/// Loading state
class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

/// State when categories are loaded
class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

/// Error state
class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
