import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../../../../../core/database/database_helper.dart';
import '../../../domain/entities/quote_entity.dart';

abstract class QuoteLocalDataSource {
  Future<void> cacheQuotes(List<QuoteEntity> quotes);
  Future<List<QuoteEntity>> getCachedQuotes();
  Future<void> clearCache();
}

@LazySingleton(as: QuoteLocalDataSource)
class QuoteLocalDataSourceImpl implements QuoteLocalDataSource {
  final DatabaseHelper _databaseHelper;
  static const String _keyQuotes = 'dashboard_quotes';

  QuoteLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> cacheQuotes(List<QuoteEntity> quotes) async {
    final data = quotes
        .map(
          (q) => {
            'id': q.id,
            'quoteText': q.quoteText,
            'author': q.author,
            'authorIconUrl': q.authorIconUrl,
            'categoryId': q.categoryId,
            'preferenceIds': q.preferenceIds,
            'isFeatured': q.isFeatured,
            'isPremium': q.isPremium,
            'quoteType': q.quoteType,
            'createdAt': q.createdAt.toIso8601String(),
            'updatedAt': q.updatedAt.toIso8601String(),
          },
        )
        .toList();
    await _databaseHelper.saveToCache(
      _keyQuotes,
      utf8.encode(jsonEncode(data)),
    );
  }

  @override
  Future<List<QuoteEntity>> getCachedQuotes() async {
    final bytes = await _databaseHelper.getFromCache(_keyQuotes);
    if (bytes != null) {
      try {
        final List<dynamic> data = jsonDecode(utf8.decode(bytes));
        return data
            .map(
              (q) => QuoteEntity(
                id: q['id'] ?? '',
                quoteText: q['quoteText'] ?? '',
                author: q['author'] ?? '',
                authorIconUrl: q['authorIconUrl'],
                categoryId: q['categoryId'],
                preferenceIds: List<String>.from(q['preferenceIds'] ?? []),
                isFeatured: q['isFeatured'] ?? false,
                isPremium: q['isPremium'] ?? false,
                quoteType: q['quoteType'] ?? 'quote',
                createdAt: DateTime.parse(
                  q['createdAt'] ?? DateTime.now().toIso8601String(),
                ),
                updatedAt: DateTime.parse(
                  q['updatedAt'] ?? DateTime.now().toIso8601String(),
                ),
              ),
            )
            .toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  @override
  Future<void> clearCache() async {
    await _databaseHelper.clearCache();
  }
}
