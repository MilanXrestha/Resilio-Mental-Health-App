import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';

/// A utility class for displaying a custom alert dialog with theme support.
class CustomAlertDialog {
  /// Shows a custom alert dialog with a title, message, and confirm/cancel buttons.
  /// Returns true if confirmed, false if canceled or dismissed.
  static Future<bool> show({
    required BuildContext context,
    required String message,
    String? title,
    String? cancelText,
    String? confirmText,
    VoidCallback? onConfirm,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = context.isDarkMode;

    final result = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          backgroundColor: context.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: isDarkMode ? 0 : 8,
          shadowColor: isDarkMode
              ? Colors.transparent
              : context.primaryColor.withOpacity(0.2),
          child: _DialogContent(
            title: title ?? l10n.alertDialogTitle,
            message: message,
            cancelText: cancelText ?? l10n.cancel,
            confirmText: confirmText ?? l10n.confirm,
            onConfirm: onConfirm,
          ),
        );
      },
    );

    return result ?? false;
  }
}

class _DialogContent extends StatelessWidget {
  final String title;
  final String message;
  final String cancelText;
  final String confirmText;
  final VoidCallback? onConfirm;

  const _DialogContent({
    required this.title,
    required this.message,
    required this.cancelText,
    required this.confirmText,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Stack(
        children: [
          // Close Icon
          Positioned(
            top: -15.h,
            right: -15.w,
            child: IconButton(
              icon: Icon(
                Icons.close_rounded,
                color: context.textPrimaryColor,
                size: 22.sp,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.all(8.w),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ),

          // Dialog Content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),

              // Title
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: context.textPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 14.h),

              // Message
              Text(
                message,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  color: context.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 26.h),

              // Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? context.textSecondaryColor.withOpacity(0.2)
                            : context.textSecondaryColor.withOpacity(0.2),
                        foregroundColor: context.textPrimaryColor,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        cancelText,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: context.textPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Confirm Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onConfirm?.call();
                        Navigator.of(context).pop(true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        confirmText,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}