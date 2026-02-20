import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resilio/core/theme/app_colors.dart';
import 'package:resilio/core/theme/color_model.dart';

/// Centralized text styles for the app using Poppins and PlayfairDisplay fonts
class AppTextStyles {
  AppTextStyles._();

  // ==================== DISPLAY ====================
  static TextStyle get displayLarge => TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        height: 1.2,
      );

  static TextStyle get displayMedium => TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        height: 1.2,
      );

  static TextStyle get displaySmall => TextStyle(
        fontFamily: 'PlayfairDisplay',
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );

  // ==================== HEADLINE ====================
  static TextStyle get headlineLarge => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );

  static TextStyle get headlineMedium => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get headlineSmall => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  // ==================== TITLE ====================
  static TextStyle get titleLarge => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get titleMedium => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 1.5,
      );

  static TextStyle get titleSmall => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.5,
      );

  // ==================== BODY ====================
  static TextStyle get bodyLarge => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );

  static TextStyle get bodySmall => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        height: 1.5,
      );

  // ==================== LABEL ====================
  static TextStyle get labelLarge => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );

  static TextStyle get labelMedium => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  static TextStyle get labelSmall => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
      );

  // ==================== BUTTON ====================
  static TextStyle get buttonLarge => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        height: 1.25,
      );

  static TextStyle get buttonMedium => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.25,
      );

  static TextStyle get buttonSmall => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        height: 1.25,
      );

  // ==================== ONBOARDING SPECIFIC ====================
  static TextStyle get onboardingTitle => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        height: 1.2,
      );

  static TextStyle get onboardingDescription => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        height: 1.5,
      );

  static TextStyle get onboardingButton => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        height: 1.25,
      );

  static TextStyle get languageButton => TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.4,
      );
}
