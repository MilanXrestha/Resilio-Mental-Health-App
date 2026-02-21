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
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimary.light,
      onError: Colors.white,
    ),
    // Card theme with enhanced shadows for depth
    cardTheme: CardThemeData(
      color: AppColors.surface.light,
      elevation: 4,
      shadowColor: AppColors.primary.light.withAlpha(30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    // Input decoration with better contrast
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface.light,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.border.light, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.border.light, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.primary.light, width: 2.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.error.light, width: 1.5),
      ),
      hintStyle: TextStyle(
        color: AppColors.textHint.light,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    ),
    // Elevated button with enhanced shadows and gradient-like effect
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        shadowColor: AppColors.primary.light.withAlpha(60),
        backgroundColor: AppColors.primary.light,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    // Outlined button for secondary actions with better visibility
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary.light,
        side: BorderSide(color: AppColors.border.light, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    // Text button for subtle actions
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary.light,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    // App bar with transparent background
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.textPrimary.light),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary.light,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
    // Divider theme
    dividerTheme: DividerThemeData(
      color: AppColors.divider.light,
      thickness: 1,
      space: 1,
    ),
    // Checkbox theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary.light;
        }
        return AppColors.border.light;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
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
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimary.dark,
      onError: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface.dark,
      elevation: 2,
      shadowColor: Colors.black.withAlpha(40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface.dark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.border.dark, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.primary.dark, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.error.dark, width: 1),
      ),
      hintStyle: TextStyle(
        color: AppColors.textHint.dark,
        fontSize: 15,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shadowColor: AppColors.primary.dark.withAlpha(40),
        backgroundColor: AppColors.primary.dark,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary.dark,
        side: BorderSide(color: AppColors.primary.dark, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary.dark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.textPrimary.dark),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary.dark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.divider.dark,
      thickness: 1,
      space: 1,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary.dark;
        }
        return AppColors.border.dark;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}
