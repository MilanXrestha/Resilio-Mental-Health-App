import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/cubit/theme_cubit.dart';
import '../../domain/entities/app_settings_entity.dart';
import '../../../../../../l10n/app_localizations.dart';

class SettingsThemeSelector extends StatelessWidget {
  final AppTheme currentTheme;
  final ValueChanged<AppTheme> onThemeChanged;

  const SettingsThemeSelector({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
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
                  Icons.palette_rounded,
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
                      'Theme',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Customize your app interface',
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
                child: _ThemeOptionCard(
                  title: 'System',
                  icon: Icons.brightness_auto_rounded,
                  isSelected: currentTheme == AppTheme.system,
                  onTap: () {
                    onThemeChanged(AppTheme.system);
                    // ThemeCubit doesn't have system explicitly, but typically maps empty or logic
                    context.read<ThemeCubit>().setThemeMode(ThemeMode.system);
                  },
                  isDarkMode: isDarkMode,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _ThemeOptionCard(
                  title: 'Light',
                  icon: Icons.light_mode_rounded,
                  isSelected: currentTheme == AppTheme.light,
                  onTap: () {
                    onThemeChanged(AppTheme.light);
                    context.read<ThemeCubit>().setThemeMode(ThemeMode.light);
                  },
                  isDarkMode: isDarkMode,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _ThemeOptionCard(
                  title: 'Dark',
                  icon: Icons.dark_mode_rounded,
                  isSelected: currentTheme == AppTheme.dark,
                  onTap: () {
                    onThemeChanged(AppTheme.dark);
                    context.read<ThemeCubit>().setThemeMode(ThemeMode.dark);
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

class _ThemeOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDarkMode;

  const _ThemeOptionCard({
    required this.title,
    required this.icon,
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
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
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
        child: Column(
          children: [
            Icon(
              icon,
              size: 24.w,
              color: isSelected ? Theme.of(context).primaryColor : (isDarkMode ? Colors.white70 : Colors.black54),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
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
