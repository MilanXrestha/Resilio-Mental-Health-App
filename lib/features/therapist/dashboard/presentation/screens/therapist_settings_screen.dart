import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/cubit/theme_cubit.dart';
import '../bloc/therapist_cubit.dart';
import '../bloc/therapist_state.dart';
import '../../../../customer/auth/presentation/bloc/auth_bloc.dart';
import '../../../../customer/auth/presentation/bloc/auth_event.dart';

class TherapistSettingsScreen extends StatefulWidget {
  const TherapistSettingsScreen({super.key});

  @override
  State<TherapistSettingsScreen> createState() => _TherapistSettingsScreenState();
}

class _TherapistSettingsScreenState extends State<TherapistSettingsScreen> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((pi) {
      if (mounted) setState(() => _appVersion = pi.version);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TherapistCubit>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState.themeMode == ThemeMode.dark;
        final isNepali = themeState.locale.languageCode == 'ne';

        return Scaffold(
          backgroundColor: context.backgroundColor,
          appBar: AppBar(
            title: Text(
              'Settings',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor),
            ),
            backgroundColor: context.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: context.textPrimaryColor),
              onPressed: () => context.pop(),
            ),
          ),
          body: SafeArea(
            child: BlocBuilder<TherapistCubit, TherapistState>(
              builder: (context, state) {
                final isVerified = state.hasProfile && (state.profile!['isVerified'] as bool? ?? false);
                final profilePicUrl = state.hasProfile ? (state.profile!['profilePictureUrl'] as String?) : null;
                final displayName = state.hasProfile ? (state.profile!['displayName'] as String? ?? '') : '';

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 40.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Card - links to edit profile
                      _ProfileCard(
                        name: displayName,
                        profilePicUrl: profilePicUrl,
                        isVerified: isVerified,
                        onTap: () => context.push('/therapist/edit-profile'),
                      ),
                      SizedBox(height: 32.h),

                      // Appearance and Language integrated directly
                      _SectionHeader(title: 'Appearance & Language', subtitle: 'Localize and theme your app'),
                      SizedBox(height: 12.h),
                      _Card(
                        children: [
                          _buildToggleSetting(
                            icon: Icons.dark_mode_rounded,
                            iconColor: const Color(0xFF8B5CF6),
                            title: 'Dark Mode',
                            value: isDarkMode,
                            onChanged: (val) {
                              context.read<ThemeCubit>().toggleTheme();
                            },
                          ),
                          Divider(color: context.dividerColor, height: 1),
                          _buildToggleSetting(
                            icon: Icons.language_rounded,
                            iconColor: const Color(0xFF10B981),
                            title: 'Nepali Language',
                            value: isNepali,
                            onChanged: (val) {
                              context.read<ThemeCubit>().toggleLocale();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Account
                      _SectionHeader(title: 'Account', subtitle: 'Security settings'),
                      SizedBox(height: 12.h),
                      _Card(
                        children: [
                          _SettingsTile(
                            icon: Icons.lock_outline_rounded,
                            title: 'Change Password',
                            subtitle: 'Update your password',
                            onTap: () => _showChangePasswordSheet(),
                          ),
                          Divider(color: context.dividerColor, height: 1),
                          _SettingsTile(
                            icon: Icons.info_outline_rounded,
                            title: 'About',
                            subtitle: 'Version $_appVersion',
                            onTap: () {},
                          ),
                          Divider(color: context.dividerColor, height: 1),
                          _SettingsTile(
                            icon: Icons.logout_rounded,
                            title: 'Sign Out',
                            titleColor: context.errorColor,
                            iconColor: context.errorColor,
                            onTap: () => context.read<AuthBloc>().add(LogoutRequested()),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildToggleSetting({
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w500, color: context.textPrimaryColor)),
          ),
          Switch.adaptive(value: value, onChanged: onChanged, activeColor: iconColor),
        ],
      ),
    );
  }

  void _showChangePasswordSheet() {
    final currentCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, MediaQuery.of(ctx).viewInsets.bottom + 34.h),
        decoration: BoxDecoration(color: context.surfaceColor, borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2.r)))),
            SizedBox(height: 20.h),
            Text('Change Password', style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
            SizedBox(height: 20.h),
            TextField(controller: currentCtrl, obscureText: true, decoration: InputDecoration(labelText: 'Current Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)))),
            SizedBox(height: 14.h),
            TextField(controller: newCtrl, obscureText: true, decoration: InputDecoration(labelText: 'New Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)))),
            SizedBox(height: 14.h),
            TextField(controller: confirmCtrl, obscureText: true, decoration: InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)))),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () async {
                  if (newCtrl.text.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password must be at least 6 characters')));
                    return;
                  }
                  if (newCtrl.text != confirmCtrl.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
                    return;
                  }
                  Navigator.pop(ctx);
                  await context.read<TherapistCubit>().changePassword(currentCtrl.text, newCtrl.text);
                  if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Password updated'), backgroundColor: context.successColor));
                },
                style: ElevatedButton.styleFrom(backgroundColor: context.primaryColor, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r))),
                child: const Text('Update Password', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w700, color: context.textSecondaryColor)),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String name;
  final String? profilePicUrl;
  final bool isVerified;
  final VoidCallback onTap;
  const _ProfileCard({required this.name, this.profilePicUrl, required this.isVerified, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(color: context.surfaceColor, borderRadius: BorderRadius.circular(16.r), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))]),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(shape: BoxShape.circle, color: context.primaryColor.withValues(alpha: 0.1)),
              child: CircleAvatar(
                radius: 32.r,
                backgroundColor: context.primaryColor.withValues(alpha: 0.05),
                backgroundImage: (profilePicUrl != null && profilePicUrl!.isNotEmpty) ? NetworkImage(profilePicUrl!) : null,
                child: (profilePicUrl == null || profilePicUrl!.isEmpty) ? Icon(Icons.person_rounded, size: 32.sp, color: context.primaryColor) : null,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(child: Text(name.isEmpty ? 'Your Name' : name, style: TextStyle(fontFamily: 'Poppins', fontSize: 17.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor), overflow: TextOverflow.ellipsis)),
                      if (isVerified) ...[SizedBox(width: 6.w), Icon(Icons.verified_rounded, size: 18.sp, color: const Color(0xFF10B981))],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(color: isVerified ? const Color(0xFF10B981).withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8.r)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(isVerified ? 'Edit Profile' : 'Pending Review', style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, fontWeight: FontWeight.w600, color: isVerified ? const Color(0xFF10B981) : Colors.orange)),
                        SizedBox(width: 4.w),
                        Icon(Icons.chevron_right_rounded, size: 14.sp, color: isVerified ? const Color(0xFF10B981) : Colors.orange),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final List<Widget> children;
  const _Card({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: context.surfaceColor, borderRadius: BorderRadius.circular(16.r), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)]),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final Color? titleColor;
  final VoidCallback onTap;
  const _SettingsTile({required this.icon, required this.title, this.subtitle, this.iconColor, this.titleColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(color: (iconColor ?? context.primaryColor).withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
              child: Icon(icon, size: 20.sp, color: iconColor ?? context.primaryColor),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w600, color: titleColor ?? context.textPrimaryColor)),
                  if (subtitle != null) Text(subtitle!, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 20.sp, color: context.textSecondaryColor),
          ],
        ),
      ),
    );
  }
}
