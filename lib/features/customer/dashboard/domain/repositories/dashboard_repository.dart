import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/user_profile_entity.dart';

/// Repository interface for dashboard user operations
abstract class DashboardRepository {
  /// Gets user profile (uses stored auth token via interceptor)
  Future<Either<Failure, UserProfile>> getUserProfile();
}