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

  // ─── Bottom Nav Bar ───
  Color get navBarBackgroundColor => AppColors.navBarBackground.of(this);

  Color get navBarChipColor => AppColors.navBarChip.of(this);

  Color get navBarUnselectedIconBgColor =>
      AppColors.navBarUnselectedIconBg.of(this);

  Color get navBarSelectedIconColor => AppColors.navBarSelectedIcon.of(this);

  Color get navBarBorderColor => AppColors.navBarBorder.of(this);
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
    Color(0xB3FFFFFF), // dark - white 70%
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

  // ==================== BOTTOM NAV BAR ====================
  static const navBarBackground = AppColor(
    Color(0xFFFFFFFF), // light - pure white
    Color(0xFF121212), // dark - deep black
  );

  static const navBarChip = AppColor(
    Color(0xFFF0F0F0), // light - light gray
    Color(0xFF1E1E1E), // dark - dark gray
  );

  static const navBarUnselectedIconBg = AppColor(
    Color(0xFFE8E8E8), // light - soft gray
    Color(0xFF262626), // dark - charcoal
  );

  static const navBarSelectedIcon = AppColor(
    Color(0xFFFFFFFF), // light - white icon on primary bg
    Color(0xFF000000), // dark - black icon on primary bg
  );

  static const navBarBorder = AppColor(
    Color(0xFFE0E0E0), // light - subtle border
    Color(0xFF2A2A2A), // dark - subtle border
  );

  static const navBarShadow = AppColor(
    Color(0x14000000), // light - 8% black
    Color(0x66000000), // dark - 40% black
  );
}
