import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/constants/api_endpoints.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/proto_generated/category.pb.dart';
import '../../../domain/entities/category_entity.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryEntity>> getCategories();
}

@LazySingleton(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio _dio;

  CategoryRemoteDataSourceImpl(this._dio);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.categories,
        options: Options(
          headers: {
            'Accept': 'application/x-protobuf',
            'X-Protobuf-Message-Type': 'ListCategoriesResponse',
          },
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final bytes = response.data as List<int>;
        final listResponse = ListCategoriesResponse.fromBuffer(bytes);
        
        return listResponse.categories.map((proto) {
          return CategoryEntity(
            id: proto.id,
            name: proto.name,
            imageUrl: proto.imageUrl,
            description: proto.description,
            preferenceIds: proto.preferenceIds,
            createdAt: DateTime.parse(proto.createdAt),
            updatedAt: DateTime.parse(proto.updatedAt),
          );
        }).toList();
      }

      return [];
    } on DioException catch (e) {
      throw NetworkFailure('Failed to fetch categories: ${e.message}');
    } catch (e) {
      throw NetworkFailure('Failed to fetch categories: $e');
    }
  }
}
