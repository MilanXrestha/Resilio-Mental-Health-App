// lib/theme/app_colors.dart
import 'package:flutter/material.dart';
import 'color_model.dart';

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
    Color(0xFFFFFFFF), // light
    Color(0xFF000000), // dark
  );

  static const surface = AppColor(
    Color(0xFFF5F5F5), // light
    Color(0xFF1E1E1E), // dark
  );

  // ==================== TEXT ====================
  static const textPrimary = AppColor(
    Color(0xFF222222), // light
    Color(0xB3FFFFFF), // dark
  );

  static const textSecondary = AppColor(
    Color(0xFF666666), // light
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