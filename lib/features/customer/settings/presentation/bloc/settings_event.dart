import 'package:equatable/equatable.dart';

import '../../domain/entities/app_settings_entity.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {
  const LoadSettings();
}

class UpdateTheme extends SettingsEvent {
  final AppTheme theme;

  const UpdateTheme(this.theme);

  @override
  List<Object?> get props => [theme];
}

class UpdateLanguage extends SettingsEvent {
  final AppLanguage language;

  const UpdateLanguage(this.language);

  @override
  List<Object?> get props => [language];
}

class ToggleNotifications extends SettingsEvent {
  final bool enabled;

  const ToggleNotifications(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class SetReminderTime extends SettingsEvent {
  final String? time;

  const SetReminderTime(this.time);

  @override
  List<Object?> get props => [time];
}

class ResetSettings extends SettingsEvent {
  const ResetSettings();
}
