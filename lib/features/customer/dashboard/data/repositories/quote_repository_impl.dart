import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/quote_entity.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/remote/quote_remote_data_source.dart';

import '../../../../../core/network/network_info.dart';
import '../datasources/local/quote_local_data_source.dart';

@LazySingleton(as: QuoteRepository)
class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource _remoteDataSource;
  final QuoteLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  QuoteRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, List<QuoteEntity>>> getFeaturedQuotes({
    int limit = 10,
    List<String>? preferenceIds,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        try {
          final quotes = await _remoteDataSource.getFeaturedQuotes(
            limit: limit,
            preferenceIds: preferenceIds,
          );
          await _localDataSource.cacheQuotes(quotes);
          return Right(quotes);
        } catch (e) {
          final cachedQuotes = await _localDataSource.getCachedQuotes();
          if (cachedQuotes.isNotEmpty) {
            return Right(cachedQuotes);
          }
          return Left(NetworkFailure('Failed to fetch featured quotes: $e'));
        }
      } else {
        final cachedQuotes = await _localDataSource.getCachedQuotes();
        if (cachedQuotes.isNotEmpty) {
          return Right(cachedQuotes);
        }
        return const Left(NetworkFailure('No internet connection and no cached quotes available'));
      }
    } catch (e) {
      return Left(NetworkFailure('Failed to fetch featured quotes: $e'));
    }
  }

  @override
  Future<Either<Failure, QuoteEntity>> getQuoteById(String id) async {
    try {
      if (await _networkInfo.isConnected) {
        final quote = await _remoteDataSource.getQuoteById(id);
        return Right(quote);
      } else {
        final cachedQuotes = await _localDataSource.getCachedQuotes();
        final quote = cachedQuotes.firstWhere((q) => q.id == id);
        return Right(quote);
      }
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
      if (await _networkInfo.isConnected) {
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
          if (result['quotes'] != null) {
            await _localDataSource.cacheQuotes(result['quotes'] as List<QuoteEntity>);
          }
          return Right(result);
        } catch (e) {
          final cachedQuotes = await _localDataSource.getCachedQuotes();
          if (cachedQuotes.isNotEmpty) {
            return Right({'quotes': cachedQuotes, 'totalCount': cachedQuotes.length});
          }
          return Left(NetworkFailure('Failed to fetch quotes: $e'));
        }
      } else {
        final cachedQuotes = await _localDataSource.getCachedQuotes();
        if (cachedQuotes.isNotEmpty) {
          return Right({'quotes': cachedQuotes, 'totalCount': cachedQuotes.length});
        }
        return const Left(NetworkFailure('No internet connection and no cached quotes available'));
      }
    } catch (e) {
      return Left(NetworkFailure('Failed to fetch quotes: $e'));
    }
  }
}
