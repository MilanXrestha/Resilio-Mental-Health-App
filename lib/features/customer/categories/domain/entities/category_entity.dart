import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final List<String> preferenceIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.preferenceIds,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        description,
        preferenceIds,
        createdAt,
        updatedAt,
      ];
}
