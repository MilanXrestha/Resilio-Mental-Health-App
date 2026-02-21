import 'package:equatable/equatable.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all available preferences
class LoadPreferencesEvent extends PreferencesEvent {
  const LoadPreferencesEvent();
}

/// Event to load user's selected preferences
class LoadUserPreferencesEvent extends PreferencesEvent {
  const LoadUserPreferencesEvent();
}

/// Event to toggle a preference selection
class TogglePreferenceEvent extends PreferencesEvent {
  final String preferenceId;

  const TogglePreferenceEvent(this.preferenceId);

  @override
  List<Object?> get props => [preferenceId];
}

/// Event to save user preferences
class SavePreferencesEvent extends PreferencesEvent {
  const SavePreferencesEvent();
}

/// Event to check if user has completed preferences
class CheckPreferencesCompletionEvent extends PreferencesEvent {
  const CheckPreferencesCompletionEvent();
}
