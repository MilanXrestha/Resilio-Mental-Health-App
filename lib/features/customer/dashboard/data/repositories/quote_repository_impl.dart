import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/quote_entity.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/remote/quote_remote_data_source.dart';

@LazySingleton(as: QuoteRepository)
class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource _remoteDataSource;

  QuoteRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<QuoteEntity>>> getFeaturedQuotes({
    int limit = 10,
    List<String>? preferenceIds,
  }) async {
    try {
      final quotes = await _remoteDataSource.getFeaturedQuotes(
        limit: limit,
        preferenceIds: preferenceIds,
      );
      return Right(quotes);
    } on NetworkFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkFailure('Failed to fetch featured quotes: $e'));
    }
  }

  @override
  Future<Either<Failure, QuoteEntity>> getQuoteById(String id) async {
    try {
      final quote = await _remoteDataSource.getQuoteById(id);
      return Right(quote);
    } on NetworkFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkFailure('Failed to fetch quote: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> listQuotes({
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? quoteType,
    List<String>? preferenceIds,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final result = await _remoteDataSource.listQuotes(
        categoryId: categoryId,
        isFeatured: isFeatured,
        isPremium: isPremium,
        quoteType: quoteType,
        preferenceIds: preferenceIds,
        limit: limit,
        offset: offset,
      );
      return Right(result);
    } on NetworkFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(NetworkFailure('Failed to fetch quotes: $e'));
    }
  }
}
