// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background.light,
    primaryColor: AppColors.primary.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary.light,
      secondary: AppColors.secondary.light,
      surface: AppColors.surface.light,
      error: AppColors.error.light,
    ),
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background.dark,
    primaryColor: AppColors.primary.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary.dark,
      secondary: AppColors.secondary.dark,
      surface: AppColors.surface.dark,
      error: AppColors.error.dark,
    ),
  );
}
