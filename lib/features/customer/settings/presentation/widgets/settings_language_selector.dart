import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/theme/cubit/theme_cubit.dart';
import '../../domain/entities/app_settings_entity.dart';
import '../../../../../../l10n/app_localizations.dart';

class SettingsLanguageSelector extends StatelessWidget {
  final AppLanguage currentLanguage;
  final ValueChanged<AppLanguage> onLanguageChanged;

  const SettingsLanguageSelector({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.language_rounded,
                  size: 20.w,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.accLanguage,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      l10n.accSelectPreferredLanguage,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _LanguageOptionCard(
                  title: l10n.accEnglish,
                  flagAsset: 'assets/icons/svg/flag_uk.svg',
                  isSelected: currentLanguage == AppLanguage.english,
                  onTap: () {
                    onLanguageChanged(AppLanguage.english);
                    context.read<ThemeCubit>().setLocale(const Locale('en'));
                  },
                  isDarkMode: isDarkMode,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _LanguageOptionCard(
                  title: l10n.accNepali,
                  flagAsset: 'assets/icons/svg/flag_nepal.svg',
                  isSelected: currentLanguage == AppLanguage.nepali,
                  onTap: () {
                    onLanguageChanged(AppLanguage.nepali);
                    context.read<ThemeCubit>().setLocale(const Locale('ne'));
                  },
                  isDarkMode: isDarkMode,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LanguageOptionCard extends StatelessWidget {
  final String title;
  final String flagAsset;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDarkMode;

  const _LanguageOptionCard({
    required this.title,
    required this.flagAsset,
    required this.isSelected,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: isDarkMode ? 0.3 : 0.1)
              : (isDarkMode ? Colors.white.withValues(alpha: 0.05) : Colors.white),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : (isDarkMode ? Colors.white.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.2)),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: (!isDarkMode && !isSelected)
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              flagAsset,
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(width: 10.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
