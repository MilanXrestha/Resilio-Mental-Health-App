import 'package:equatable/equatable.dart';

import 'preference_entity.dart';

/// User Preference Entry Entity
/// Represents a single preference selected by a user
class UserPreferenceEntryEntity extends Equatable {
  final String preferenceId;
  final DateTime? selectedAt;

  const UserPreferenceEntryEntity({
    required this.preferenceId,
    this.selectedAt,
  });

  @override
  List<Object?> get props => [preferenceId, selectedAt];

  UserPreferenceEntryEntity copyWith({
    String? preferenceId,
    DateTime? selectedAt,
  }) {
    return UserPreferenceEntryEntity(
      preferenceId: preferenceId ?? this.preferenceId,
      selectedAt: selectedAt ?? this.selectedAt,
    );
  }
}

/// User Preference with Details Entity
/// Represents a user's selected preference with full preference details
class UserPreferenceWithDetailsEntity extends Equatable {
  final String id;
  final String userId;
  final PreferenceEntity preference;
  final DateTime? selectedAt;
  final DateTime? updatedAt;

  const UserPreferenceWithDetailsEntity({
    required this.id,
    required this.userId,
    required this.preference,
    this.selectedAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [id, userId, preference, selectedAt, updatedAt];

  UserPreferenceWithDetailsEntity copyWith({
    String? id,
    String? userId,
    PreferenceEntity? preference,
    DateTime? selectedAt,
    DateTime? updatedAt,
  }) {
    return UserPreferenceWithDetailsEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      preference: preference ?? this.preference,
      selectedAt: selectedAt ?? this.selectedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
