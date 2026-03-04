import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all available categories
class LoadCategoriesEvent extends CategoryEvent {
  const LoadCategoriesEvent();
}
