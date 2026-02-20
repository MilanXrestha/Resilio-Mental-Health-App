import 'package:Resilio/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';


import '../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/onboarding_entity.dart';

/// A stateless widget that displays the content for an onboarding screen.
class OnboardingContent extends StatelessWidget {
  final OnboardingEntity entity;

  const OnboardingContent({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie animation with background glow
          Container(
            height: 280.h,
            width: 280.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  context.primaryColor.withValues(alpha: isDarkMode ? 0.2 : 0.15),
                  Colors.transparent,
                ],
                radius: 0.8,
              ),
            ),
            child: Lottie.asset(
              entity.lottieAsset,
              height: 250.h,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 40.h),

          // Title
          Text(
            entity.title,
            style: AppTextStyles.onboardingTitle.copyWith(
              color: context.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),

          // Description
          Text(
            entity.description,
            style: AppTextStyles.onboardingDescription.copyWith(
              color: context.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
