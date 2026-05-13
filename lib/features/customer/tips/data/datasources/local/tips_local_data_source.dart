import 'package:injectable/injectable.dart';
import '../../../../../../core/database/database_helper.dart';
import '../../../domain/entities/tip_entity.dart';

abstract class TipsLocalDataSource {
  Future<List<TipEntity>> getTips({String? categoryId});
  Future<void> saveTips(List<TipEntity> tips);
  Future<void> clearTips();
  Future<bool> isCacheValid();
}

@LazySingleton(as: TipsLocalDataSource)
class TipsLocalDataSourceImpl implements TipsLocalDataSource {
  final DatabaseHelper databaseHelper;

  TipsLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<List<TipEntity>> getTips({String? categoryId}) async {
    final maps = await databaseHelper.getTips(categoryId: categoryId);
    return maps.map(_mapToTipEntity).toList();
  }

  @override
  Future<void> saveTips(List<TipEntity> tips) async {
    final maps = tips.map((tip) {
      return {
        'id': tip.id,
        'title': tip.title,
        'content': tip.tipText,
        'categoryId': tip.categoryId,
        'imageUrl': tip.authorIconUrl,
        'author': tip.author,
        'authorIconUrl': tip.authorIconUrl,
        'tipType': tip.tipType.toString(),
        'isFeatured': tip.isFeatured,
        'isPremium': tip.isPremium,
        'sortOrder': tip.sortOrder,
        'metadata': tip.metadata,
        'preferenceIds': tip.preferenceIds,
        'createdAt': tip.createdAt.toIso8601String(),
        'updatedAt': tip.updatedAt.toIso8601String(),
      };
    }).toList();

    await databaseHelper.saveTips(maps);
    await databaseHelper.updateSyncMetadata('tips', DatabaseHelper.cacheValidityDefault);
  }

  @override
  Future<void> clearTips() async {
    await databaseHelper.clearTips();
  }

  @override
  Future<bool> isCacheValid() async {
    return await databaseHelper.shouldSync('tips') == false;
  }

  TipEntity _mapToTipEntity(Map<String, dynamic> map) {
    return TipEntity(
      id: map['id'] as String,
      title: map['title'] as String,
      tipText: map['content'] as String? ?? '',
      author: map['author'] as String? ?? '',
      authorIconUrl: map['authorIconUrl'] as String? ?? '',
      categoryId: map['categoryId'] as String? ?? '',
      preferenceIds: List<String>.from(map['preferenceIds'] as List? ?? []),
      tipType: _parseTipType(map['tipType'] as String?),
      isFeatured: (map['isFeatured'] as int? ?? 0) == 1,
      isPremium: (map['isPremium'] as int? ?? 0) == 1,
      sortOrder: map['sortOrder'] as int? ?? 0,
      metadata: map['metadata'] as String? ?? '',
      createdAt: DateTime.parse(map['createdAt'] as String? ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] as String? ?? DateTime.now().toIso8601String()),
    );
  }

  TipType _parseTipType(String? type) {
    if (type == null) return TipType.unknown;
    if (type.contains('relationshipBooster')) return TipType.relationshipBooster;
    if (type.contains('lettingGo')) return TipType.lettingGo;
    if (type.contains('communication')) return TipType.communication;
    if (type.contains('selfCare')) return TipType.selfCare;
    if (type.contains('mindfulness')) return TipType.mindfulness;
    if (type.contains('general')) return TipType.general;
    return TipType.unknown;
  }
}
