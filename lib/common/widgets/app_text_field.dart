import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// A reusable text field widget with consistent styling across the app
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.onTap,
    this.autofocus = false,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          textInputAction: textInputAction,
          focusNode: focusNode,
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readOnly,
          onTap: onTap,
          autofocus: autofocus,
          style: AppTextStyles.bodyLarge.copyWith(
            color: context.textPrimaryColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodyLarge.copyWith(
              color: context.textSecondaryColor.withOpacity(0.5),
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: context.textSecondaryColor,
                    size: 20.sp,
                  )
                : null,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
            filled: true,
            fillColor: context.isDarkMode
                ? Colors.white.withOpacity(0.05)
                : Colors.grey.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: context.primaryColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            errorStyle: AppTextStyles.bodySmall.copyWith(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

/// A widget that unfocuses text fields when tapping outside
class UnfocusOnTap extends StatelessWidget {
  final Widget child;

  const UnfocusOnTap({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
