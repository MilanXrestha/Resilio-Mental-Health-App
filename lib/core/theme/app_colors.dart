// lib/theme/app_colors.dart
import 'package:Resilio/core/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'color_model.dart';

/// Extension to get colors easily without context
extension ColorContext on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  
  // Common
  Color get primaryColor => AppColors.primary.of(this);
  Color get errorColor => AppColors.error.of(this);
  Color get accentBlueColor => AppColors.accentBlue.of(this);
  
  // Background
  Color get backgroundColor => AppColors.background.of(this);
  Color get surfaceColor => AppColors.surface.of(this);
  
  // Text
  Color get textPrimaryColor => AppColors.textPrimary.of(this);
  Color get textSecondaryColor => AppColors.textSecondary.of(this);
  Color get textHintColor => AppColors.textHint.of(this);
  
  // Status
  Color get successColor => AppColors.success.of(this);
  Color get warningColor => AppColors.warning.of(this);
  
  // Border
  Color get borderColor => AppColors.border.of(this);
  Color get dividerColor => AppColors.divider.of(this);
}

class AppColors {
  AppColors._();

  // ==================== PRIMARY (Fresh Teal - Modern & Calming) ====================
  static const primary = AppColor(
    Color(0xFF0D9488), // light - vibrant teal (more energetic)
    Color(0xFF14B8A6), // dark
  );

  // ==================== SECONDARY (Soft Coral) ====================
  static const secondary = AppColor(
    Color(0xFFF97316), // light - warm coral accent
    Color(0xFFFB923C), // dark
  );

  // ==================== ACCENT (Ocean Blue) ====================
  static const accentBlue = AppColor(
    Color(0xFF3B82F6), // light - bright blue
    Color(0xFF60A5FA), // dark
  );

  // ==================== ERROR (Rose Red) ====================
  static const error = AppColor(
    Color(0xFFE11D48), // light - vibrant rose
    Color(0xFFF43F5E), // dark
  );

  static const shadow = AppColor.all(Color(0x1F000000));
  static const overlay = AppColor.all(Color(0x42000000));

  // ==================== BACKGROUND ====================
  // Clean white with subtle warmth
  static const background = AppColor(
    Color(0xFFFAFAF9), // light - warm white (stone-50)
    Color(0xFF121212), // dark
  );

  static const surface = AppColor(
    Color(0xFFFFFFFF), // light - pure white for cards
    Color(0xFF1E1E1E), // dark
  );

  // ==================== TEXT (Rich Dark) ====================
  static const textPrimary = AppColor(
    Color(0xFF1C1917), // light - rich dark (stone-900)
    Color(0xFFFFFFFF), // dark
  );

  static const textSecondary = AppColor(
    Color(0xFF57534E), // light - warm gray (stone-600)
    Color(0xB3FFFFFF), // dark
  );

  static const textHint = AppColor(
    Color(0xFFA8A29E), // light - muted gray (stone-400)
    Color(0xFF9E9E9E), // dark
  );

  // ==================== STATUS ====================
  static const success = AppColor(
    Color(0xFF10B981), // light - emerald green
    Color(0xFF34D399), // dark
  );

  static const warning = AppColor(
    Color(0xFFF59E0B), // light - amber
    Color(0xFFFBBF24), // dark
  );

  // ==================== BORDER ====================
  static const border = AppColor(
    Color(0xFFE7E5E4), // light - stone-200
    Color(0xFF424242), // dark
  );

  static const divider = AppColor(
    Color(0xFFF5F5F4), // light - stone-100
    Color(0xFF303030), // dark
  );
}