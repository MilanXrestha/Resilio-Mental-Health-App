import 'package:injectable/injectable.dart';

import '../datasources/remote/content_remote_datasource.dart';
import '../../domain/entities/content_item_entity.dart';
import '../../domain/repositories/content_repository.dart';

@LazySingleton(as: ContentRepository)
class ContentRepositoryImpl implements ContentRepository {
  final ContentRemoteDataSource _dataSource;

  ContentRepositoryImpl(this._dataSource);

  /// Extract the list from the response map keyed by content type.
  /// Backend returns { tips: [...] }, { quotes: [...] }, { videos: [...] }, { tracks: [...] }
  List<Map<String, dynamic>> _extractList(String type, Map<String, dynamic> raw) {
    final key = type == 'audio' ? 'tracks' : type;
    final list = raw[key] as List<dynamic>? ?? [];
    return list.cast<Map<String, dynamic>>();
  }

  /// Extract the single item from the response map.
  /// Backend returns { tip: {...} }, { quote: {...} }, { video: {...} }, { audio: {...} }
  Map<String, dynamic> _extractItem(String type, Map<String, dynamic> raw) {
    final key = type == 'audio' ? 'audio' : type.substring(0, type.length - 1);
    return raw[key] as Map<String, dynamic>? ?? raw;
  }

  @override
  Future<List<ContentItemEntity>> getContent(String type) async {
    try {
      final raw = await _dataSource.getContent(type);
      final items = _extractList(type, raw);
      return items.map((m) => ContentItemEntity.fromMap(type, m)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ContentItemEntity> createContent(String type, Map<String, dynamic> data) async {
    try {
      final raw = await _dataSource.createContent(type, data);
      final item = _extractItem(type, raw);
      return ContentItemEntity.fromMap(type, item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ContentItemEntity> updateContent(String type, String id, Map<String, dynamic> data) async {
    try {
      final raw = await _dataSource.updateContent(type, id, data);
      final item = _extractItem(type, raw);
      return ContentItemEntity.fromMap(type, item);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteContent(String type, String id) async {
    try {
      return await _dataSource.deleteContent(type, id);
    } catch (e) {
      rethrow;
    }
  }
}
