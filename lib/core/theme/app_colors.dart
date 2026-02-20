// lib/theme/app_colors.dart
import 'package:flutter/material.dart';
import 'package:resilio/core/theme/theme_extension.dart';
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

  // ==================== COMMON ====================
  static const primary = AppColor.all(Color(0xFF4CAF50));
  static const error = AppColor.all(Color(0xFFD32F2F));
  static const accentBlue = AppColor.all(Color(0xFF2196F3));
  static const shadow = AppColor.all(Color(0x1F000000));
  static const overlay = AppColor.all(Color(0x42000000));

  // ==================== BACKGROUND ====================
  static const background = AppColor(
    Color(0xFFF8FAF9), // light - slightly off-white for better contrast
    Color(0xFF121212), // dark
  );

  static const surface = AppColor(
    Color(0xFFFFFFFF), // light
    Color(0xFF1E1E1E), // dark
  );

  // ==================== TEXT ====================
  static const textPrimary = AppColor(
    Color(0xFF1A1A1A), // light - darker for better contrast
    Color(0xFFFFFFFF), // dark
  );

  static const textSecondary = AppColor(
    Color(0xFF5A5A5A), // light - darker gray
    Color(0xB3FFFFFF), // dark
  );

  static const textHint = AppColor(
    Color(0xFF9E9E9E), // light
    Color(0xFF9E9E9E), // dark
  );

  // ==================== SECONDARY ====================
  static const secondary = AppColor(
    Color(0xFF333333), // light
    Color(0xFF262626), // dark
  );

  // ==================== STATUS ====================
  static const success = AppColor(
    Color(0xFF4CAF50), // light
    Color(0xFF81C784), // dark
  );

  static const warning = AppColor(
    Color(0xFFFFA726), // light
    Color(0xFFFFB74D), // dark
  );

  // ==================== BORDER ====================
  static const border = AppColor(
    Color(0xFFE0E0E0), // light
    Color(0xFF424242), // dark
  );

  static const divider = AppColor(
    Color(0xFFEEEEEE), // light
    Color(0xFF303030), // dark
  );
}