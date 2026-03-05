import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/proto_generated/images.pb.dart';
import '../../../domain/entities/image_entity.dart';
import '../../../domain/repositories/image_repository.dart';

abstract class ImageRemoteDataSource {
  Future<List<ImageEntity>> getFeaturedImages({
    int limit = 10,
    List<String>? preferenceIds,
    String? imageType,
  });

  Future<ImageEntity> getImageById(String imageId);

  Future<ImagesListResult> listImages({
    int limit = 20,
    int offset = 0,
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? imageType,
    List<String>? preferenceIds,
  });

  Future<ImagesListResult> getImagesByType({
    required String imageType,
    int limit = 20,
    int offset = 0,
  });
}

@LazySingleton(as: ImageRemoteDataSource)
class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final Dio _dio;

  ImageRemoteDataSourceImpl(this._dio);

  /// Common request options for protobuf
  Options get _protoOptions => Options(
        headers: {
          'Accept': 'application/x-protobuf',
        },
        responseType: ResponseType.bytes,
      );

  @override
  Future<List<ImageEntity>> getFeaturedImages({
    int limit = 10,
    List<String>? preferenceIds,
    String? imageType,
  }) async {
    try {
      print('🖼️ Fetching featured images from: ${ApiEndpoints.imagesFeatured}');
      
      final queryParams = <String, dynamic>{
        'limit': limit.toString(),
      };

      if (preferenceIds != null && preferenceIds.isNotEmpty) {
        queryParams['preferenceIds'] = preferenceIds.join(',');
      }

      if (imageType != null && imageType.isNotEmpty) {
        queryParams['imageType'] = imageType;
      }

      print('📋 Query params: $queryParams');

      final response = await _dio.get(
        ApiEndpoints.imagesFeatured,
        queryParameters: queryParams,
        options: _protoOptions,
      );

      print('✅ Images response status: ${response.statusCode}');
      print('📦 Images response data length: ${response.data?.length ?? 0} bytes');

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = GetFeaturedImagesResponse.fromBuffer(bytes);
        
        print('🎯 Parsed ${result.images.length} images');

        return result.images.map(_mapToEntity).toList();
      }

      print('⚠️ No images data in response');
      return [];
    } on DioException catch (e) {
      print('❌ Images network error: ${e.message}');
      print('❌ Images error response: ${e.response?.data}');
      throw NetworkFailure('Failed to fetch featured images: ${e.message}');
    } catch (e) {
      print('❌ Images error: $e');
      throw NetworkFailure('Failed to fetch featured images: $e');
    }
  }

  @override
  Future<ImageEntity> getImageById(String imageId) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.images}/$imageId',
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = Image.fromBuffer(bytes);
        return _mapToEntity(result);
      }

      throw NetworkFailure('Image not found: ${response.statusCode}');
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch image: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch image: $e');
    }
  }

  @override
  Future<ImagesListResult> listImages({
    int limit = 20,
    int offset = 0,
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? imageType,
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

      if (imageType != null && imageType.isNotEmpty) {
        queryParams['imageType'] = imageType;
      }

      if (preferenceIds != null && preferenceIds.isNotEmpty) {
        queryParams['preferenceIds'] = preferenceIds.join(',');
      }

      final response = await _dio.get(
        ApiEndpoints.images,
        queryParameters: queryParams,
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = ListImagesResponse.fromBuffer(bytes);

        return ImagesListResult(
          images: result.images.map(_mapToEntity).toList(),
          totalCount: result.pagination.total,
        );
      }

      return const ImagesListResult(images: [], totalCount: 0);
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch images: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch images: $e');
    }
  }

  @override
  Future<ImagesListResult> getImagesByType({
    required String imageType,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'limit': limit.toString(),
        'offset': offset.toString(),
      };

      final response = await _dio.get(
        '${ApiEndpoints.imagesByType}/$imageType',
        queryParameters: queryParams,
        options: _protoOptions,
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final result = GetImagesByTypeResponse.fromBuffer(bytes);

        return ImagesListResult(
          images: result.images.map(_mapToEntity).toList(),
          totalCount: result.totalCount,
        );
      }

      return const ImagesListResult(images: [], totalCount: 0);
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch images by type: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch images by type: $e');
    }
  }

  /// Map protobuf Image to ImageEntity
  ImageEntity _mapToEntity(Image image) {
    return ImageEntity(
      id: image.id,
      title: image.title,
      description: image.description,
      imageUrl: image.imageUrl,
      thumbnailUrl: image.thumbnailUrl,
      author: image.author,
      authorIconUrl: image.authorIconUrl,
      categoryId: image.categoryId,
      preferenceIds: image.preferenceIds.toList(),
      imageType: _parseImageType(image.imageType),
      isFeatured: image.isFeatured,
      isPremium: image.isPremium,
      resolutionWidth: image.resolutionWidth,
      resolutionHeight: image.resolutionHeight,
      fileSizeBytes: image.fileSizeBytes.toInt(),
      downloadCount: image.downloadCount,
      sortOrder: image.sortOrder,
      metadata: image.metadata,
      createdAt: DateTime.tryParse(image.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(image.updatedAt) ?? DateTime.now(),
    );
  }

  /// Parse image type from string
  ImageType _parseImageType(String type) {
    switch (type.toLowerCase()) {
      case 'motivation':
        return ImageType.motivation;
      case 'nature':
        return ImageType.nature;
      case 'quotes':
        return ImageType.quotes;
      case 'abstract':
        return ImageType.abstract;
      case 'spiritual':
        return ImageType.spiritual;
      case 'general':
        return ImageType.general;
      default:
        return ImageType.unknown;
    }
  }
}
