// lib/theme/color_model.dart
import 'package:flutter/material.dart';

class AppColor {
  final Color light;
  final Color dark;

  const AppColor(this.light, this.dark);

  /// Same color for both themes
  const AppColor.all(Color color) : light = color, dark = color;

  /// Resolve based on brightness
  Color resolve(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }
}