import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/proto_generated/quote.pb.dart';
import '../../../domain/entities/quote_entity.dart';

/// Remote data source for quote operations - uses Node.js backend API
abstract class QuoteRemoteDataSource {
  /// Get featured quotes
  Future<List<QuoteEntity>> getFeaturedQuotes({
    int limit = 10,
    List<String>? preferenceIds,
  });

  /// Get quote by ID
  Future<QuoteEntity> getQuoteById(String id);

  /// List quotes with filters
  Future<Map<String, dynamic>> listQuotes({
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? quoteType,
    List<String>? preferenceIds,
    int limit = 20,
    int offset = 0,
  });
}

@LazySingleton(as: QuoteRemoteDataSource)
class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final Dio _dio;

  QuoteRemoteDataSourceImpl(this._dio);

  @override
  Future<List<QuoteEntity>> getFeaturedQuotes({
    int limit = 10,
    List<String>? preferenceIds,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit.toString(),
      };

      if (preferenceIds != null && preferenceIds.isNotEmpty) {
        queryParams['preferenceIds'] = preferenceIds.join(',');
      }

      final response = await _dio.get(
        ApiEndpoints.quotesFeatured,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Accept': 'application/x-protobuf',
            'X-Protobuf-Message-Type': 'GetFeaturedQuotesResponse',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final listResponse = GetFeaturedQuotesResponse.fromBuffer(bytes);

        return listResponse.quotes.map((proto) => _mapToEntity(proto)).toList();
      }

      return [];
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch featured quotes: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch featured quotes: $e');
    }
  }

  @override
  Future<QuoteEntity> getQuoteById(String id) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.quotes}/$id',
        options: Options(
          headers: {
            'Accept': 'application/x-protobuf',
            'X-Protobuf-Message-Type': 'Quote',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final quote = Quote.fromBuffer(bytes);
        return _mapToEntity(quote);
      }

      throw NetworkFailure('Quote not found');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw NetworkFailure('Quote not found');
      }
      throw NetworkFailure('Failed to fetch quote: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch quote: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> listQuotes({
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? quoteType,
    List<String>? preferenceIds,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };

      if (categoryId != null) queryParams['categoryId'] = categoryId;
      if (isFeatured != null) queryParams['isFeatured'] = isFeatured.toString();
      if (isPremium != null) queryParams['isPremium'] = isPremium.toString();
      if (quoteType != null) queryParams['quoteType'] = quoteType;
      if (preferenceIds != null && preferenceIds.isNotEmpty) {
        queryParams['preferenceIds'] = preferenceIds.join(',');
      }

      final response = await _dio.get(
        ApiEndpoints.quotes,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Accept': 'application/x-protobuf',
            'X-Protobuf-Message-Type': 'ListQuotesResponse',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final listResponse = ListQuotesResponse.fromBuffer(bytes);

        return {
          'quotes': listResponse.quotes.map((proto) => _mapToEntity(proto)).toList(),
          'pagination': {
            'page': listResponse.pagination.page,
            'limit': listResponse.pagination.limit,
            'total': listResponse.pagination.total,
            'totalPages': listResponse.pagination.totalPages,
          },
        };
      }

      return {'quotes': [], 'pagination': null};
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch quotes: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch quotes: $e');
    }
  }

  /// Map protobuf Quote to QuoteEntity
  QuoteEntity _mapToEntity(Quote proto) {
    return QuoteEntity(
      id: proto.id,
      quoteText: proto.quoteText,
      author: proto.author,
      authorIconUrl: proto.authorIconUrl.isNotEmpty ? proto.authorIconUrl : null,
      categoryId: proto.categoryId.isNotEmpty ? proto.categoryId : null,
      preferenceIds: proto.preferenceIds,
      isFeatured: proto.isFeatured,
      isPremium: proto.isPremium,
      quoteType: proto.quoteType,
      createdAt: DateTime.parse(proto.createdAt),
      updatedAt: DateTime.parse(proto.updatedAt),
    );
  }
}
