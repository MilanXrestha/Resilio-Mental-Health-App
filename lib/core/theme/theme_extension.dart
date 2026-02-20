// lib/theme/theme_extension.dart
import 'package:flutter/material.dart';
import 'color_model.dart';

extension ColorExtension on AppColor {
  /// Resolve color from context
  Color of(BuildContext context) => resolve(context);
}

extension ThemeExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}