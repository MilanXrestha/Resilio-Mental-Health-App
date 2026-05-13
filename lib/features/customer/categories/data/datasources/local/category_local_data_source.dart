import 'package:injectable/injectable.dart';
import '../../../../../../core/database/database_helper.dart';
import '../../../domain/entities/category_entity.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryEntity>> getCategories();
  Future<void> saveCategories(List<CategoryEntity> categories);
  Future<void> clearCategories();
  Future<bool> isCacheValid();
}

@LazySingleton(as: CategoryLocalDataSource)
class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final DatabaseHelper databaseHelper;

  CategoryLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final maps = await databaseHelper.getCategories();
    return maps.map((map) {
      return CategoryEntity(
        id: map['id'] as String,
        name: map['name'] as String,
        imageUrl: map['imageUrl'] as String,
        description: map['description'] as String? ?? '',
        preferenceIds: List<String>.from(map['preferenceIds'] as List? ?? []),
        createdAt: DateTime.parse(map['createdAt'] as String? ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(map['updatedAt'] as String? ?? DateTime.now().toIso8601String()),
      );
    }).toList();
  }

  @override
  Future<void> saveCategories(List<CategoryEntity> categories) async {
    final maps = categories.map((category) {
      return {
        'id': category.id,
        'name': category.name,
        'description': category.description,
        'imageUrl': category.imageUrl,
        'preferenceIds': category.preferenceIds,
        'createdAt': category.createdAt.toIso8601String(),
        'updatedAt': category.updatedAt.toIso8601String(),
      };
    }).toList();

    await databaseHelper.saveCategories(maps);
    await databaseHelper.updateSyncMetadata('categories', DatabaseHelper.cacheValidityDefault);
  }

  @override
  Future<void> clearCategories() async {
    await databaseHelper.clearCategories();
  }

  @override
  Future<bool> isCacheValid() async {
    return await databaseHelper.shouldSync('categories') == false;
  }
}
