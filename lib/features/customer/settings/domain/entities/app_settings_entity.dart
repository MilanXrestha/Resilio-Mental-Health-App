enum AppTheme { light, dark, system }

enum AppLanguage {
  english,
  nepali,
}

class AppSettingsEntity {
  final AppTheme theme;
  final AppLanguage language;
  final bool notificationsEnabled;
  final bool dailyRemindersEnabled;
  final String? reminderTime; // HH:mm format
  final bool soundEnabled;
  final double volumeLevel;
  final bool downloadOnWifiOnly;
  final bool dataSaverMode;
  final bool privacyMode; // Hide sensitive content in notifications
  final String? selectedVoiceId; // For audio playback
  final double playbackSpeed;

  const AppSettingsEntity({
    this.theme = AppTheme.system,
    this.language = AppLanguage.english,
    this.notificationsEnabled = true,
    this.dailyRemindersEnabled = true,
    this.reminderTime,
    this.soundEnabled = true,
    this.volumeLevel = 1.0,
    this.downloadOnWifiOnly = false,
    this.dataSaverMode = false,
    this.privacyMode = false,
    this.selectedVoiceId,
    this.playbackSpeed = 1.0,
  });

  AppSettingsEntity copyWith({
    AppTheme? theme,
    AppLanguage? language,
    bool? notificationsEnabled,
    bool? dailyRemindersEnabled,
    String? reminderTime,
    bool? soundEnabled,
    double? volumeLevel,
    bool? downloadOnWifiOnly,
    bool? dataSaverMode,
    bool? privacyMode,
    String? selectedVoiceId,
    double? playbackSpeed,
  }) {
    return AppSettingsEntity(
      theme: theme ?? this.theme,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      dailyRemindersEnabled: dailyRemindersEnabled ?? this.dailyRemindersEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      volumeLevel: volumeLevel ?? this.volumeLevel,
      downloadOnWifiOnly: downloadOnWifiOnly ?? this.downloadOnWifiOnly,
      dataSaverMode: dataSaverMode ?? this.dataSaverMode,
      privacyMode: privacyMode ?? this.privacyMode,
      selectedVoiceId: selectedVoiceId ?? this.selectedVoiceId,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
    );
  }
}
