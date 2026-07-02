import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/theme/cubit/theme_cubit.dart';
import 'package:Resilio/l10n/app_localizations.dart';

class AdminMoreScreen extends StatelessWidget {
  const AdminMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              _buildHeader(context),
              SizedBox(height: 24.h),
              _buildSectionLabel(context, 'Quick Actions'),
              SizedBox(height: 12.h),
              _buildMenuCard(
                context: context,
                index: 0,
                icon: Icons.campaign_rounded,
                title: l.admPushNotifications,
                subtitle: l.admPushNotificationsSubtitle,
                color: const Color(0xFFEC4899),
                onTap: () => context.push('/admin-notifications'),
              ),
              SizedBox(height: 10.h),
              _buildMenuCard(
                context: context,
                index: 1,
                icon: Icons.app_settings_alt_rounded,
                title: l.admPreferencesConfig,
                subtitle: l.admPreferencesConfigSubtitle,
                color: const Color(0xFF10B981),
                onTap: () => context.push('/admin-preferences'),
              ),
              SizedBox(height: 10.h),
              _buildMenuCard(
                context: context,
                index: 2,
                icon: Icons.bar_chart_rounded,
                title: l.admRevenueAnalytics,
                subtitle: l.admRevenueAnalyticsSubtitle,
                color: const Color(0xFF6366F1),
                onTap: () => context.push('/admin-revenue'),
              ),
              SizedBox(height: 24.h),
              _buildSectionLabel(context, 'Preferences'),
              SizedBox(height: 12.h),
              _buildThemeToggle(context),
              SizedBox(height: 10.h),
              _buildLocaleToggle(context),
              SizedBox(height: 24.h),
              _buildSectionLabel(context, 'Account'),
              SizedBox(height: 12.h),
              _buildMenuCard(
                context: context,
                index: 5,
                icon: Icons.settings_rounded,
                title: l.admSettings,
                subtitle: l.admSettingsSubtitle,
                color: const Color(0xFF8B5CF6),
                onTap: () => context.push('/admin-settings'),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('More', style: TextStyle(fontFamily: 'Poppins', fontSize: 24.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor, letterSpacing: -0.5)),
            Text('Tools & settings', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textSecondaryColor)),
          ],
        ),
        GestureDetector(
          onTap: () => context.push('/admin-settings'),
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: context.surfaceColor,
              shape: BoxShape.circle,
              border: Border.all(color: context.dividerColor, width: 1.5),
            ),
            child: Icon(Icons.settings_outlined, color: context.textPrimaryColor, size: 22.sp),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1);
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Text(label.toUpperCase(), style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, fontWeight: FontWeight.w700, color: context.textSecondaryColor, letterSpacing: 0.8));
  }

  Widget _buildMenuCard({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: context.dividerColor, width: 1),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8)],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor)),
                  Text(subtitle, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: context.textSecondaryColor, size: 14.sp),
          ],
        ),
      ),
    ).animate(delay: (index * 60).ms).fadeIn().slideX(begin: 0.04);
  }

  Widget _buildThemeToggle(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;
        return GestureDetector(
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: context.dividerColor),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
                  child: Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded, color: const Color(0xFF8B5CF6), size: 22.sp),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dark Mode', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor)),
                      Text(isDark ? 'Currently dark' : 'Currently light', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
                    ],
                  ),
                ),
                Switch.adaptive(value: isDark, onChanged: (_) => context.read<ThemeCubit>().toggleTheme(), activeColor: const Color(0xFF8B5CF6)),
              ],
            ),
          ),
        ).animate(delay: 240.ms).fadeIn();
      },
    );
  }

  Widget _buildLocaleToggle(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isNepali = state.locale.languageCode == 'ne';
        return GestureDetector(
          onTap: () => context.read<ThemeCubit>().toggleLocale(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: context.dividerColor),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
                  child: Icon(Icons.language_rounded, color: const Color(0xFF10B981), size: 22.sp),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nepali Language', style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor)),
                      Text(isNepali ? 'नेपाली सक्रिय छ' : 'English is active', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
                    ],
                  ),
                ),
                Switch.adaptive(value: isNepali, onChanged: (_) => context.read<ThemeCubit>().toggleLocale(), activeColor: const Color(0xFF10B981)),
              ],
            ),
          ),
        ).animate(delay: 300.ms).fadeIn();
      },
    );
  }
}
