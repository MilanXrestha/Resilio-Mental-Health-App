import 'package:dartz/dartz.dart';

import 'package:Resilio/core/errors/failures.dart';
import '../entities/preference_entity.dart';
import '../entities/user_preference_entity.dart';

/// Preference Repository Interface
/// Defines the contract for preference data operations
abstract class PreferenceRepository {
  /// Get all available preferences
  Future<Either<Failure, List<PreferenceEntity>>> getAllPreferences();

  /// Get user's selected preferences
  Future<Either<Failure, List<UserPreferenceWithDetailsEntity>>> getUserPreferences();

  /// Save user preferences (replaces existing)
  Future<Either<Failure, List<UserPreferenceWithDetailsEntity>>> saveUserPreferences(
    List<String> preferenceIds,
  );

  /// Check if user has completed preferences
  Future<Either<Failure, bool>> hasCompletedPreferences();

  /// Clear local preference data (useful on logout)
  Future<Either<Failure, void>> clearLocalData();
}
