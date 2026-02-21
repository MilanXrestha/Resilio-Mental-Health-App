import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';

/// Dummy home screen shown after successful login
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        title: Text(
          'Resilio',
          style: AppTextStyles.headlineSmall.copyWith(
            color: context.primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
              context.goNamed(RouteNames.login);
            },
            icon: Icon(
              Icons.logout,
              color: context.textPrimaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Home!',
                style: AppTextStyles.headlineLarge.copyWith(
                  color: context.textPrimaryColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'You have successfully logged in.',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: context.textSecondaryColor,
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: context.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 64.sp,
                      color: context.primaryColor,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Authentication Successful',
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'This is a placeholder home screen. Replace it with your actual app content.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOutRequested());
                    context.goNamed(RouteNames.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Sign Out',
                    style: AppTextStyles.buttonMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
