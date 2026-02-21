import 'package:equatable/equatable.dart';

import '../../domain/entities/preference_entity.dart';

abstract class PreferencesState extends Equatable {
  const PreferencesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PreferencesInitial extends PreferencesState {
  const PreferencesInitial();
}

/// Loading state
class PreferencesLoading extends PreferencesState {
  const PreferencesLoading();
}

/// State when preferences are loaded
class PreferencesLoaded extends PreferencesState {
  final List<PreferenceEntity> preferences;
  final List<String> selectedPreferenceIds;
  final bool hasCompletedPreferences;

  const PreferencesLoaded({
    required this.preferences,
    this.selectedPreferenceIds = const [],
    this.hasCompletedPreferences = false,
  });

  PreferencesLoaded copyWith({
    List<PreferenceEntity>? preferences,
    List<String>? selectedPreferenceIds,
    bool? hasCompletedPreferences,
  }) {
    return PreferencesLoaded(
      preferences: preferences ?? this.preferences,
      selectedPreferenceIds: selectedPreferenceIds ?? this.selectedPreferenceIds,
      hasCompletedPreferences: hasCompletedPreferences ?? this.hasCompletedPreferences,
    );
  }

  @override
  List<Object?> get props => [preferences, selectedPreferenceIds, hasCompletedPreferences];
}

/// State when user preferences are saved
class PreferencesSaved extends PreferencesState {
  const PreferencesSaved();
}

/// Error state
class PreferencesError extends PreferencesState {
  final String message;

  const PreferencesError(this.message);

  @override
  List<Object?> get props => [message];
}
