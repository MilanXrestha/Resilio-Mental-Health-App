import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/cubit/theme_cubit.dart';
import '../../l10n/app_localizations.dart';

/// A reusable widget for language and theme toggle buttons
/// Matches the style used in onboarding screen
/// Language button on LEFT, Theme button on RIGHT
/// Shows OPPOSITE language (Nepali button when English is on, English button when Nepali is on)
class SettingsToggleWidget extends StatelessWidget {
  final VoidCallback? onLanguageTap;
  final VoidCallback? onThemeTap;

  const SettingsToggleWidget({
    super.key,
    this.onLanguageTap,
    this.onThemeTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDarkMode = state.isDarkMode;
        final isEnglish = state.isEnglish;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Language toggle button (LEFT side) - Shows OPPOSITE language
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onLanguageTap ?? () => _toggleLanguage(context),
                borderRadius: BorderRadius.circular(22.r),
                splashColor: context.primaryColor.withValues(alpha: 0.1),
                highlightColor: context.primaryColor.withValues(alpha: 0.05),
                child: Container(
                  width: 110.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withValues(alpha: 0.1)
                        : context.surfaceColor,
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.2)
                          : context.borderColor,
                      width: 1.5,
                    ),
                    boxShadow: isDarkMode
                        ? null
                        : [
                            BoxShadow(
                              color: const Color(0xFF000000).withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Show OPPOSITE flag
                      SvgPicture.asset(
                        isEnglish
                            ? 'assets/icons/svg/flag_nepal.svg'
                            : 'assets/icons/svg/flag_uk.svg',
                        width: 20.w,
                        height: 20.w,
                      ),
                      SizedBox(width: 8.w),
                      // Show OPPOSITE language text
                      Text(
                        isEnglish ? l10n.languageNepali : l10n.languageEnglish,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: context.textPrimaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Theme toggle button (RIGHT side)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onThemeTap ?? () => _toggleTheme(context),
                borderRadius: BorderRadius.circular(22.r),
                splashColor: context.primaryColor.withValues(alpha: 0.1),
                highlightColor: context.primaryColor.withValues(alpha: 0.05),
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.white.withValues(alpha: 0.1)
                        : context.surfaceColor,
                    borderRadius: BorderRadius.circular(22.r),
                    border: Border.all(
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.2)
                          : context.borderColor,
                      width: 1.5,
                    ),
                    boxShadow: isDarkMode
                        ? null
                        : [
                            BoxShadow(
                              color: const Color(0xFF000000).withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Center(
                    child: Icon(
                      isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      color: isDarkMode ? const Color(0xFFFFB300) : context.textPrimaryColor,
                      size: 22.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleLanguage(BuildContext context) {
    context.read<ThemeCubit>().toggleLocale();
  }

  void _toggleTheme(BuildContext context) {
    context.read<ThemeCubit>().toggleTheme();
  }
}
