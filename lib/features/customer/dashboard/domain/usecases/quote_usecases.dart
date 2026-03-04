import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/quote_entity.dart';
import '../../domain/repositories/quote_repository.dart';

/// Use case for getting featured quotes
@lazySingleton
class GetFeaturedQuotes {
  final QuoteRepository _repository;

  GetFeaturedQuotes(this._repository);

  Future<Either<Failure, List<QuoteEntity>>> call({
    int limit = 10,
    List<String>? preferenceIds,
  }) async {
    return await _repository.getFeaturedQuotes(
      limit: limit,
      preferenceIds: preferenceIds,
    );
  }
}

/// Use case for getting a quote by ID
@lazySingleton
class GetQuoteById {
  final QuoteRepository _repository;

  GetQuoteById(this._repository);

  Future<Either<Failure, QuoteEntity>> call(String id) async {
    return await _repository.getQuoteById(id);
  }
}

/// Use case for listing quotes with filters
@lazySingleton
class ListQuotes {
  final QuoteRepository _repository;

  ListQuotes(this._repository);

  Future<Either<Failure, Map<String, dynamic>>> call({
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? quoteType,
    List<String>? preferenceIds,
    int limit = 20,
    int offset = 0,
  }) async {
    return await _repository.listQuotes(
      categoryId: categoryId,
      isFeatured: isFeatured,
      isPremium: isPremium,
      quoteType: quoteType,
      preferenceIds: preferenceIds,
      limit: limit,
      offset: offset,
    );
  }
}
