import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

/// Cubit for managing theme and locale settings
@lazySingleton
class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _prefs;
  
  static const _keyThemeMode = 'theme_mode';
  static const _keyLocale = 'locale';

  ThemeCubit(this._prefs) : super(const ThemeState()) {
    _loadSavedSettings();
  }

  /// Load saved settings from SharedPreferences
  void _loadSavedSettings() {
    final themeStr = _prefs.getString(_keyThemeMode);
    final themeMode = switch (themeStr) {
      'dark' => ThemeMode.dark,
      _ => ThemeMode.light,
    };
    
    final localeStr = _prefs.getString(_keyLocale);
    final locale = switch (localeStr) {
      'ne' => const Locale('ne'),
      _ => const Locale('en'),
    };
    
    emit(ThemeState(
      themeMode: themeMode,
      locale: locale,
    ));
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final newMode = state.themeMode == ThemeMode.dark 
        ? ThemeMode.light 
        : ThemeMode.dark;
    
    await _prefs.setString(
      _keyThemeMode,
      newMode == ThemeMode.dark ? 'dark' : 'light',
    );
    
    emit(state.copyWith(themeMode: newMode));
  }

  /// Set specific theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (state.themeMode == mode) return;
    
    await _prefs.setString(
      _keyThemeMode,
      mode == ThemeMode.dark ? 'dark' : 'light',
    );
    
    emit(state.copyWith(themeMode: mode));
  }

  /// Toggle between English and Nepali
  Future<void> toggleLocale() async {
    final newLocale = state.locale.languageCode == 'en'
        ? const Locale('ne')
        : const Locale('en');
    
    await _prefs.setString(_keyLocale, newLocale.languageCode);
    
    emit(state.copyWith(locale: newLocale));
  }

  /// Set specific locale
  Future<void> setLocale(Locale locale) async {
    if (state.locale.languageCode == locale.languageCode) return;
    
    await _prefs.setString(_keyLocale, locale.languageCode);
    
    emit(state.copyWith(locale: locale));
  }
}
