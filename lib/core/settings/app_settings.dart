import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _keyThemeMode = 'theme_mode';
const _keyLocale = 'locale';

/// Manages app-wide settings (theme, locale) with SharedPreferences persistence.
class AppSettings extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');
  bool _initialized = false;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get isInitialized => _initialized;

  /// Load saved settings from SharedPreferences.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final themeStr = prefs.getString(_keyThemeMode);
    _themeMode = switch (themeStr) {
      'dark' => ThemeMode.dark,
      _ => ThemeMode.light,
    };
    final localeStr = prefs.getString(_keyLocale);
    _locale = switch (localeStr) {
      'ne' => const Locale('ne'),
      _ => const Locale('en'),
    };
    _initialized = true;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _keyThemeMode,
      switch (mode) {
        ThemeMode.dark => 'dark',
        _ => 'light',
      },
    );
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale.languageCode == locale.languageCode) return;
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocale, locale.languageCode);
    notifyListeners();
  }
}
