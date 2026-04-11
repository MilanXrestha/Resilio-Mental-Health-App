import '../entities/content_item_entity.dart';

abstract class ContentRepository {
  Future<List<ContentItemEntity>> getContent(String type);
  Future<ContentItemEntity> createContent(String type, Map<String, dynamic> data);
  Future<ContentItemEntity> updateContent(String type, String id, Map<String, dynamic> data);
  Future<bool> deleteContent(String type, String id);
}
