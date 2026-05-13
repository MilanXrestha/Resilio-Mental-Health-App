import 'package:Resilio/core/database/database_helper.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/affirmation_entity.dart';

abstract class AffirmationLocalDataSource {
  Future<List<AffirmationEntity>> getAffirmations({String? categoryId});
  Future<void> saveAffirmations(List<AffirmationEntity> affirmations);
  Future<void> clearAffirmations();
  Future<bool> isCacheValid();
}

@LazySingleton(as: AffirmationLocalDataSource)
class AffirmationLocalDataSourceImpl implements AffirmationLocalDataSource {
  final DatabaseHelper databaseHelper;

  AffirmationLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<AffirmationEntity>> getAffirmations({String? categoryId}) async {
    final maps = await databaseHelper.getAffirmations(categoryId: categoryId);
    return maps.map(_mapToAffirmationEntity).toList();
  }

  @override
  Future<void> saveAffirmations(List<AffirmationEntity> affirmations) async {
    final maps = affirmations.map((affirmation) {
      return {
        'id': affirmation.id,
        'text': affirmation.text,
        'categoryId': affirmation.category,
        'userId': affirmation.userId,
        'backgroundColor': affirmation.backgroundColor,
        'iconName': affirmation.iconName,
        'words': affirmation.words,
        'difficulty': affirmation.difficulty,
        'createdAt': affirmation.createdAt.toIso8601String(),
      };
    }).toList();

    await databaseHelper.saveAffirmations(maps);
    await databaseHelper.updateSyncMetadata('affirmations', DatabaseHelper.cacheValidityDefault);
  }

  @override
  Future<void> clearAffirmations() async {
    await databaseHelper.clearAffirmations();
  }

  @override
  Future<bool> isCacheValid() async {
    return await databaseHelper.shouldSync('affirmations') == false;
  }

  AffirmationEntity _mapToAffirmationEntity(Map<String, dynamic> map) {
    return AffirmationEntity(
      id: map['id'] as String,
      userId: map['userId'] as String? ?? '',
      text: map['text'] as String,
      backgroundColor: map['backgroundColor'] as String? ?? '#000000',
      iconName: map['iconName'] as String? ?? '',
      createdAt: DateTime.parse(map['createdAt'] as String? ?? DateTime.now().toIso8601String()),
      words: List<String>.from(map['words'] as List? ?? []),
      difficulty: map['difficulty'] as int? ?? 1,
      category: map['categoryId'] as String? ?? 'General',
    );
  }
}
