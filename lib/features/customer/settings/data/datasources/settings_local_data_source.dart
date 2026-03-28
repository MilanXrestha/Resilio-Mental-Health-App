import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/app_settings_entity.dart';

abstract class SettingsLocalDataSource {
  Future<AppSettingsEntity> getSettings();
  Future<void> saveSettings(AppSettingsEntity settings);
}

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences _prefs;

  SettingsLocalDataSourceImpl({required SharedPreferences prefs})
      : _prefs = prefs;

  @override
  Future<AppSettingsEntity> getSettings() async {
    var themeIndex = _prefs.getInt('theme') ?? 2; // system default
    if (themeIndex >= AppTheme.values.length) themeIndex = 2;
    var languageIndex = _prefs.getInt('language') ?? 0; // english default
    if (languageIndex >= AppLanguage.values.length) languageIndex = 0;

    return AppSettingsEntity(
      theme: AppTheme.values[themeIndex],
      language: AppLanguage.values[languageIndex],
      notificationsEnabled: _prefs.getBool('notifications_enabled') ?? true,
      dailyRemindersEnabled: _prefs.getBool('daily_reminders') ?? true,
      reminderTime: _prefs.getString('reminder_time'),
      soundEnabled: _prefs.getBool('sound_enabled') ?? true,
      volumeLevel: _prefs.getDouble('volume_level') ?? 1.0,
      downloadOnWifiOnly: _prefs.getBool('wifi_only') ?? false,
      dataSaverMode: _prefs.getBool('data_saver') ?? false,
      privacyMode: _prefs.getBool('privacy_mode') ?? false,
      selectedVoiceId: _prefs.getString('voice_id'),
      playbackSpeed: _prefs.getDouble('playback_speed') ?? 1.0,
    );
  }

  @override
  Future<void> saveSettings(AppSettingsEntity settings) async {
    await _prefs.setInt('theme', settings.theme.index);
    await _prefs.setInt('language', settings.language.index);
    await _prefs.setBool('notifications_enabled', settings.notificationsEnabled);
    await _prefs.setBool('daily_reminders', settings.dailyRemindersEnabled);
    if (settings.reminderTime != null) {
      await _prefs.setString('reminder_time', settings.reminderTime!);
    }
    await _prefs.setBool('sound_enabled', settings.soundEnabled);
    await _prefs.setDouble('volume_level', settings.volumeLevel);
    await _prefs.setBool('wifi_only', settings.downloadOnWifiOnly);
    await _prefs.setBool('data_saver', settings.dataSaverMode);
    await _prefs.setBool('privacy_mode', settings.privacyMode);
    if (settings.selectedVoiceId != null) {
      await _prefs.setString('voice_id', settings.selectedVoiceId!);
    }
    await _prefs.setDouble('playback_speed', settings.playbackSpeed);
  }
}
