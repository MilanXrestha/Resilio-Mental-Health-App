import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../entities/user_profile_entity.dart';

/// Repository interface for dashboard user operations
abstract class DashboardRepository {
  /// Gets user profile by ID using Firebase ID token for authentication
  Future<Either<Failure, UserProfile>> getUserProfile(String userId, String idToken);
}
