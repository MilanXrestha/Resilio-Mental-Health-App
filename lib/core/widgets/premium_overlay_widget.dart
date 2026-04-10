import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Resilio/core/theme/app_colors.dart';

class PremiumOverlayWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onUpgradePressed;

  const PremiumOverlayWidget({
    super.key,
    this.title = 'Premium Content',
    this.description =
        'Unlock this exclusive wellness tip with Resilio Premium.',
    required this.onUpgradePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Stack(
        children: [
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withValues(alpha: 0.3)),
          ),

          // Content
          Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.primaryColor.withValues(alpha: 0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.lock_rounded,
                      color: Colors.white,
                      size: 40.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 16.sp,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  ElevatedButton(
                    onPressed: onUpgradePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 14.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 8,
                      shadowColor: context.primaryColor.withValues(alpha: 0.5),
                    ),
                    child: Text(
                      'Upgrade to Premium',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
