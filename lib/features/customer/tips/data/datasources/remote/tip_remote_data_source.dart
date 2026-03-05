import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/proto_generated/tips.pb.dart';
import '../../../domain/entities/tip_entity.dart';
import '../../../domain/repositories/tip_repository.dart';

abstract class TipRemoteDataSource {
  Future<List<TipEntity>> getFeaturedTips({
    int limit = 10,
    List<String>? preferenceIds,
    String? tipType,
  });

  Future<TipEntity> getTipById(String tipId);

  Future<TipsListResult> listTips({
    int limit = 20,
    int offset = 0,
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? tipType,
    List<String>? preferenceIds,
  });

  Future<TipsListResult> getTipsByType({
    required String tipType,
    int limit = 20,
    int offset = 0,
  });
}

@LazySingleton(as: TipRemoteDataSource)
class TipRemoteDataSourceImpl implements TipRemoteDataSource {
  final Dio _dio;

  TipRemoteDataSourceImpl(this._dio);

  /// Common request options for protobuf
  Options get _protoOptions => Options(
        headers: {
          'Accept': 'application/x-protobuf',
        },
        responseType: ResponseType.bytes,
      );

  @override
  Future<List<TipEntity>> getFeaturedTips({
    int limit = 10,
    List<String>? preferenceIds,
    String? tipType,
  }) async {
    try {
      print('🔍 Fetching featured tips from: ${ApiEndpoints.tipsFeatured}');
      
      final queryParams = <String, dynamic>{
        'limit': limit.toString(),
      };

      if (preferenceIds != null && preferenceIds.isNotEmpty) {
        queryParams['preferenceIds'] = preferenceIds.join(',');
      }

      if (tipType != null && tipType.isNotEmpty) {
        queryParams['tipType'] = tipType;
      }

      print('📋 Query params: $queryParams');

      final response = await _dio.get(
        ApiEndpoints.tipsFeatured,
        queryParameters: queryParams,
        options: _protoOptions,
      );

      print('✅ Tips response status: ${response.statusCode}');
      print('📦 Tips response data length: ${response.data?.length ?? 0} bytes');

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = GetFeaturedTipsResponse.fromBuffer(bytes);
        
        print('🎯 Parsed ${result.tips.length} tips');

        return result.tips.map(_mapToEntity).toList();
      }

      print('⚠️ No tips data in response');
      return [];
    } on DioException catch (e) {
      print('❌ Tips network error: ${e.message}');
      print('❌ Tips error response: ${e.response?.data}');
      throw NetworkFailure('Failed to fetch featured tips: ${e.message}');
    } catch (e) {
      print('❌ Tips error: $e');
      throw NetworkFailure('Failed to fetch featured tips: $e');
    }
  }

  @override
  Future<TipEntity> getTipById(String tipId) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.tips}/$tipId',
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = Tip.fromBuffer(bytes);
        return _mapToEntity(result);
      }

      throw NetworkFailure('Tip not found: ${response.statusCode}');
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch tip: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch tip: $e');
    }
  }

  @override
  Future<TipsListResult> listTips({
    int limit = 20,
    int offset = 0,
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? tipType,
    List<String>? preferenceIds,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };

      if (categoryId != null && categoryId.isNotEmpty) {
        queryParams['categoryId'] = categoryId;
      }

      if (isFeatured != null) {
        queryParams['isFeatured'] = isFeatured.toString();
      }

      if (isPremium != null) {
        queryParams['isPremium'] = isPremium.toString();
      }

      if (tipType != null && tipType.isNotEmpty) {
        queryParams['tipType'] = tipType;
      }

      if (preferenceIds != null && preferenceIds.isNotEmpty) {
        queryParams['preferenceIds'] = preferenceIds.join(',');
      }

      final response = await _dio.get(
        ApiEndpoints.tips,
        queryParameters: queryParams,
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = ListTipsResponse.fromBuffer(bytes);

        return TipsListResult(
          tips: result.tips.map(_mapToEntity).toList(),
          totalCount: result.pagination.total,
        );
      }

      return const TipsListResult(tips: [], totalCount: 0);
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch tips: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch tips: $e');
    }
  }

  @override
  Future<TipsListResult> getTipsByType({
    required String tipType,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };

      final response = await _dio.get(
        '${ApiEndpoints.tipsByType}/$tipType',
        queryParameters: queryParams,
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = GetTipsByTypeResponse.fromBuffer(bytes);

        return TipsListResult(
          tips: result.tips.map(_mapToEntity).toList(),
          totalCount: result.totalCount,
        );
      }

      return const TipsListResult(tips: [], totalCount: 0);
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch tips by type: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch tips by type: $e');
    }
  }

  /// Map protobuf Tip to TipEntity
  TipEntity _mapToEntity(Tip tip) {
    return TipEntity(
      id: tip.id,
      title: tip.title,
      tipText: tip.tipText,
      author: tip.author,
      authorIconUrl: tip.authorIconUrl,
      categoryId: tip.categoryId,
      preferenceIds: tip.preferenceIds.toList(),
      tipType: _parseTipType(tip.tipType),
      isFeatured: tip.isFeatured,
      isPremium: tip.isPremium,
      sortOrder: tip.sortOrder,
      metadata: tip.metadata,
      createdAt: DateTime.tryParse(tip.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(tip.updatedAt) ?? DateTime.now(),
    );
  }

  /// Parse tip type from string
  TipType _parseTipType(String type) {
    switch (type.toLowerCase()) {
      case 'relationship_booster':
        return TipType.relationshipBooster;
      case 'letting_go':
        return TipType.lettingGo;
      case 'communication':
        return TipType.communication;
      case 'self_care':
        return TipType.selfCare;
      case 'mindfulness':
        return TipType.mindfulness;
      case 'general':
        return TipType.general;
      default:
        return TipType.unknown;
    }
  }
}
