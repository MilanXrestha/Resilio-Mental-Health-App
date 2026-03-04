import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/quote_entity.dart';

/// Repository interface for quote operations
abstract class QuoteRepository {
  /// Get featured quotes
  Future<Either<Failure, List<QuoteEntity>>> getFeaturedQuotes({
    int limit = 10,
    List<String>? preferenceIds,
  });

  /// Get quote by ID
  Future<Either<Failure, QuoteEntity>> getQuoteById(String id);

  /// List quotes with filters
  Future<Either<Failure, Map<String, dynamic>>> listQuotes({
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? quoteType,
    List<String>? preferenceIds,
    int limit = 20,
    int offset = 0,
  });
}
