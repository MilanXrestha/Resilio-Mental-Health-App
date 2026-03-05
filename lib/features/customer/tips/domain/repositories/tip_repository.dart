import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/tip_entity.dart';

abstract class TipRepository {
  /// Get featured tips
  Future<Either<Failure, List<TipEntity>>> getFeaturedTips({
    int limit = 10,
    List<String>? preferenceIds,
    String? tipType,
  });

  /// Get tip by ID
  Future<Either<Failure, TipEntity>> getTipById(String tipId);

  /// List tips with filters
  Future<Either<Failure, TipsListResult>> listTips({
    int limit = 20,
    int offset = 0,
    String? categoryId,
    bool? isFeatured,
    bool? isPremium,
    String? tipType,
    List<String>? preferenceIds,
  });

  /// Get tips by type
  Future<Either<Failure, TipsListResult>> getTipsByType({
    required String tipType,
    int limit = 20,
    int offset = 0,
  });
}

/// Result object for list operations
class TipsListResult {
  final List<TipEntity> tips;
  final int totalCount;

  const TipsListResult({
    required this.tips,
    required this.totalCount,
  });
}
