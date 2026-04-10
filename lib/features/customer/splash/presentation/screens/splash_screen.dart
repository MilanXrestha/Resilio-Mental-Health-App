import 'dart:async';
import 'dart:developer';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import '../../../preferences/domain/usecases/check_preferences_completion_usecase.dart';

/// Splash screen that displays branding with minimum display time
/// Shows every time app opens, then navigates to onboarding (first time) or login
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Minimum display time to prevent flashing (milliseconds)
  final int _minimumDisplayTime = 3000;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _prepareNavigation();
  }

  Future<void> _prepareNavigation() async {
    try {
      // Check if onboarding is completed
      final checkOnboardingStatus = getIt<CheckOnboardingStatusUseCase>();
      final onboardingResult = await checkOnboardingStatus.call(const NoParams());
      final onboardingCompleted = onboardingResult.getOrElse(() => false);

      // Check auth status
      final user = FirebaseAuth.instance.currentUser;
      bool preferencesCompleted = false;
      String? userRole;

      if (user != null) {
        final checkPrefsStatus = getIt<CheckPreferencesCompletionUseCase>();
        final prefsResult = await checkPrefsStatus.call(const NoParams());
        preferencesCompleted = prefsResult.getOrElse(() => false);
        
        // Use a fast local mechanism or backend check for user_role.
        // For now, assume it's stored or we go to a loading screen.
        // I will assume authTokenService or local preference has it, but wait:
        // By default, let's navigate to home which will branch if it's admin/therapist (if we implement it there)
        // Or we assume all users go to their respective dashboard here.
        // Actually, we probably should get the cached user entity to read the role.
        final cachedUserResult = await getIt<AuthRepository>().getCachedUser();
        final cachedUser = cachedUserResult.getOrElse(() => null);
        userRole = cachedUser?.role;
      }

      // Calculate elapsed time and ensure minimum display
      final elapsedMs = DateTime.now().difference(_startTime).inMilliseconds;
      final remainingMs = _minimumDisplayTime - elapsedMs;

      if (remainingMs > 0) {
        await Future.delayed(Duration(milliseconds: remainingMs));
      }

      if (!mounted) return;

      // Navigation hierarchy
      if (!onboardingCompleted) {
        context.goNamed(RouteNames.onboarding);
      } else if (user == null) {
        context.goNamed(RouteNames.login);
      } else {
        if (userRole == 'admin') {
          context.goNamed(RouteNames.adminDashboard);
        } else if (userRole == 'therapist') {
          context.goNamed(RouteNames.therapistDashboard);
        } else {
          if (!preferencesCompleted) {
            context.goNamed(RouteNames.preferences);
          } else {
            context.goNamed(RouteNames.home);
          }
        }
      }
    } catch (e) {
      log('Error in navigation preparation: $e');
      // Fallback to onboarding on error
      if (mounted) {
        context.goNamed(RouteNames.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: isDarkMode ? null : context.backgroundColor,
          gradient: isDarkMode
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.surface,
                    theme.scaffoldBackgroundColor,
                  ],
                )
              : null,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 80.h),

                // Logo
                Image.asset(
                  'assets/icons/png/wellness_logo.png',
                  height: 120.h,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: 5.h),

                // App title
                Text(
                  l10n.appTitle,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 30.sp,
                    letterSpacing: 1.5,
                    color: isDarkMode
                        ? AppColors.primary.dark
                        : AppColors.primary.light,
                    shadows: isDarkMode
                        ? [
                            Shadow(
                              offset: const Offset(1, 2),
                              blurRadius: 6,
                              color: Colors.black.withValues(alpha: 0.15),
                            ),
                          ]
                        : [],
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 3.h),

                // App subtitle
                Text(
                  l10n.appSubtitle,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: isDarkMode
                        ? AppColors.textSecondary.dark
                        : AppColors.textSecondary.light,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 50.h),

                SizedBox(height: 250.h),

                // App version info
                Text(
                  l10n.appVersion,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15.sp,
                    color: isDarkMode
                        ? AppColors.textSecondary.dark
                        : AppColors.textSecondary.light,
                  ),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Copyright footer
                Column(
                  children: [
                    Text(
                      l10n.copyright,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        color: isDarkMode
                            ? AppColors.textSecondary.dark
                            : AppColors.textSecondary.light,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
