import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../profile/presentation/widgets/profile_menu_item.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../widgets/settings_theme_selector.dart';
import '../widgets/settings_language_selector.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = '1.0.0';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appVersion = packageInfo.version;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SettingsBloc>()..add(const LoadSettings()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('App Settings'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.w),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SettingsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64.w,
                      color: Colors.redAccent,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Error loading settings',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      onPressed: () {
                        context.read<SettingsBloc>().add(const LoadSettings());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is! SettingsLoaded) {
              return const SizedBox.shrink();
            }

            final settings = state.settings;
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SettingsSectionHeader(title: 'Profile', isFirst: true),
                  ProfileMenuItem(
                    icon: Icons.person_outline_rounded,
                    title: 'Your Profile',
                    description: 'Manage account, subscription, and preferences',
                    onTap: () => context.pushNamed(RouteNames.profile),
                  ),
                  _SettingsSectionHeader(title: 'Appearance'),
                  _settingsPanel(
                    isDarkMode: isDarkMode,
                    child: SettingsThemeSelector(
                      currentTheme: settings.theme,
                      onThemeChanged: (theme) {
                        context.read<SettingsBloc>().add(UpdateTheme(theme));
                      },
                    ),
                  ),
                  _settingsPanel(
                    isDarkMode: isDarkMode,
                    child: SettingsLanguageSelector(
                      currentLanguage: settings.language,
                      onLanguageChanged: (language) {
                        context.read<SettingsBloc>().add(
                              UpdateLanguage(language),
                            );
                      },
                    ),
                  ),
                  _SettingsSectionHeader(title: 'General'),
                  ProfileMenuItem(
                    icon: Icons.refresh_rounded,
                    title: 'Reset to Defaults',
                    description: 'Restore theme and language to defaults',
                    iconColor: Colors.orange,
                    onTap: () {
                      context.read<SettingsBloc>().add(const ResetSettings());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Settings reset to defaults'),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      );
                    },
                  ),
                  _SettingsSectionHeader(title: 'About'),
                  ProfileMenuItem(
                    icon: Icons.info_outline_rounded,
                    title: 'About Resilio',
                    description: 'Version $_appVersion',
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Resilio',
                        applicationVersion: _appVersion,
                        applicationIcon: Icon(
                          Icons.self_improvement_rounded,
                          size: 48.w,
                          color: Theme.of(context).primaryColor,
                        ),
                        applicationLegalese: '© 2026 Resilio',
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _settingsPanel({
    required bool isDarkMode,
    required Widget child,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isDarkMode
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: child,
      ),
    );
  }
}

/// Section title with accent underline, aligned with reference profile settings.
class _SettingsSectionHeader extends StatelessWidget {
  final String title;
  final bool isFirst;

  const _SettingsSectionHeader({
    required this.title,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        top: isFirst ? 8.h : 24.h,
        bottom: 8.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            height: 2.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
        ],
      ),
    );
  }
}
