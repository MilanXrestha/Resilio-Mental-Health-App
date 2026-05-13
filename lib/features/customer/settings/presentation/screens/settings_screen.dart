import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../profile/presentation/widgets/premium_profile_card.dart';
import '../../../profile/presentation/widgets/profile_menu_item.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../subscription/presentation/bloc/subscription_bloc.dart';
import '../../../subscription/presentation/bloc/subscription_state.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../widgets/settings_theme_selector.dart';
import '../widgets/settings_language_selector.dart';
import 'package:Resilio/l10n/app_localizations.dart';
import 'package:Resilio/core/theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = '1.0.0';
  String _cacheSize = '...';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
    _calculateCacheSize();
  }

  Future<void> _loadAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _appVersion = info.version);
  }

  Future<void> _calculateCacheSize() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final cacheDir = await getApplicationCacheDirectory();
      int total = 0;
      for (final dir in [tempDir, cacheDir]) {
        if (await dir.exists()) {
          await for (final entity in dir.list(recursive: true)) {
            if (entity is File) total += await entity.length();
          }
        }
      }
      if (mounted) {
        setState(() =>
            _cacheSize = '${(total / (1024 * 1024)).toStringAsFixed(1)} MB');
      }
    } catch (_) {
      if (mounted) setState(() => _cacheSize = 'N/A');
    }
  }

  Future<void> _clearCache() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.clearCache),
        content:
            Text('${l10n.currentCacheSize(_cacheSize)}\n${l10n.clearCacheConfirm}'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.cancel)),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child:
                  Text(l10n.clear, style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      final tempDir = await getTemporaryDirectory();
      final cacheDir = await getApplicationCacheDirectory();
      for (final dir in [tempDir, cacheDir]) {
        if (await dir.exists()) {
          await dir.delete(recursive: true);
          await dir.create(recursive: true);
        }
      }
      await _calculateCacheSize();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.cacheCleared)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _showAboutDialog() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.all(12.w),
                child: Image.asset(
                  isDark
                      ? 'assets/icons/png/wellness_logo.png'
                      : 'assets/icons/png/wellness_logo_black.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 16.h),
              Text('Resilio',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              Text(l10n.versionLearnMore(_appVersion),
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
              SizedBox(height: 16.h),
              Divider(color: isDark ? Colors.white12 : Colors.grey.shade200),
              SizedBox(height: 12.h),
              Text(
                l10n.aboutResilioDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: isDark ? Colors.white70 : Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                alignment: WrapAlignment.center,
                children: [
                  _chip(Icons.headphones_rounded, l10n.favoriteAudio, theme),
                  _chip(Icons.videocam_rounded, l10n.favoriteVideos, theme),
                  _chip(Icons.tips_and_updates_rounded, l10n.favoriteTips, theme),
                  _chip(Icons.games_rounded, l10n.gamesHub, theme),
                  _chip(Icons.favorite_rounded, 'Wellness', theme),
                ],
              ),
              SizedBox(height: 16.h),
              Divider(color: isDark ? Colors.white12 : Colors.grey.shade200),
              SizedBox(height: 8.h),
              Text(l10n.madeWithLove,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                  textAlign: TextAlign.center),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(l10n.close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String label, ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: theme.primaryColor),
          SizedBox(width: 4.w),
          Text(label,
              style: TextStyle(
                  fontSize: 11.sp,
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SettingsBloc>()..add(const LoadSettings()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appSettings),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20.sp,
              color: context.textPrimaryColor,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoading) {
              return _SettingsShimmer(isDark: Theme.of(context).brightness == Brightness.dark);
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
                      AppLocalizations.of(context)!.errorLoadingSettings,
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
                      child: Text(AppLocalizations.of(context)!.retry),
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
                  // Premium membership card
                  BlocBuilder<SubscriptionBloc, SubscriptionState>(
                    builder: (context, subState) {
                      if (subState is SubscriptionLoaded && subState.subscription.isActive) {
                        return BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, profileState) {
                            if (profileState is ProfileLoaded) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8.h),
                                  PremiumProfileCard(
                                    profile: profileState.profile,
                                    subscription: subState.subscription,
                                  ),
                                  SizedBox(height: 16.h),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  _SettingsSectionHeader(title: AppLocalizations.of(context)!.profileSection, isFirst: true),
                  ProfileMenuItem(
                    icon: Icons.person_outline_rounded,
                    title: AppLocalizations.of(context)!.yourProfile,
                    description: AppLocalizations.of(context)!.manageAccountPrefs,
                    onTap: () => context.pushNamed(RouteNames.profile),
                  ),
                  _SettingsSectionHeader(title: AppLocalizations.of(context)!.appearanceSection),
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
                  _SettingsSectionHeader(title: AppLocalizations.of(context)!.generalSection),
                  ProfileMenuItem(
                    icon: Icons.refresh_rounded,
                    title: AppLocalizations.of(context)!.resetToDefaults,
                    description: AppLocalizations.of(context)!.restoreThemeLanguage,
                    iconColor: Colors.orange,
                    onTap: () {
                      context.read<SettingsBloc>().add(const ResetSettings());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!.settingsReset),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      );
                    },
                  ),
                  ProfileMenuItem(
                    icon: Icons.cleaning_services_outlined,
                    title: AppLocalizations.of(context)!.clearCache,
                    description: AppLocalizations.of(context)!.freeUpSpaceSize(_cacheSize),
                    onTap: _clearCache,
                  ),
                  ProfileMenuItem(
                    icon: Icons.info_outline_rounded,
                    title: AppLocalizations.of(context)!.aboutResilio,
                    description: AppLocalizations.of(context)!.versionLearnMore(_appVersion),
                    onTap: _showAboutDialog,
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

class _SettingsShimmer extends StatelessWidget {
  final bool isDark;
  const _SettingsShimmer({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final base = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlight = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium card placeholder
            Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            SizedBox(height: 24.h),
            // Section label placeholder
            Container(
              width: 100.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 12.h),
            ...List.generate(4, (i) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            )),
            SizedBox(height: 16.h),
            Container(
              width: 100.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 12.h),
            ...List.generate(3, (i) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
