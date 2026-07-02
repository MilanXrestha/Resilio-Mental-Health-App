import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Resilio/core/theme/app_colors.dart';
import 'package:Resilio/core/theme/cubit/theme_cubit.dart';
import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/core/services/cloudinary_service.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_bloc.dart';
import 'package:Resilio/features/customer/auth/presentation/bloc/auth_event.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  bool _isUploadingAvatar = false;
  String? _avatarUrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState.themeMode == ThemeMode.dark;
        final isNepali = themeState.locale.languageCode == 'ne';

        return Scaffold(
          backgroundColor: context.backgroundColor,
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App Settings', style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor, letterSpacing: -0.3)),
                Text('Customize your experience', style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
              ],
            ),
            backgroundColor: context.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: context.textPrimaryColor),
              onPressed: () => context.pop(),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection(context),
                SizedBox(height: 32.h),

                _buildSectionLabel('Appearance & Language'),
                SizedBox(height: 10.h),
                _buildCard(children: [
                  _buildToggleRow(
                    context: context,
                    icon: isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    iconColor: const Color(0xFF8B5CF6),
                    title: 'Dark Mode',
                    subtitle: isDarkMode ? 'Currently dark' : 'Currently light',
                    value: isDarkMode,
                    onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                  ),
                  _divider(context),
                  _buildToggleRow(
                    context: context,
                    icon: Icons.language_rounded,
                    iconColor: const Color(0xFF10B981),
                    title: 'Nepali Language',
                    subtitle: isNepali ? 'नेपाली सक्रिय छ' : 'English is active',
                    value: isNepali,
                    onChanged: (_) => context.read<ThemeCubit>().toggleLocale(),
                  ),
                ]),

                SizedBox(height: 24.h),
                _buildSectionLabel('Platform Management'),
                SizedBox(height: 10.h),
                _buildCard(children: [
                  _buildActionRow(
                    context: context,
                    icon: Icons.app_settings_alt_rounded,
                    iconColor: const Color(0xFFF59E0B),
                    title: 'Onboarding Preferences',
                    subtitle: 'Manage category options',
                    onTap: () => context.push('/admin-preferences'),
                  ),
                  _divider(context),
                  _buildActionRow(
                    context: context,
                    icon: Icons.campaign_rounded,
                    iconColor: const Color(0xFFEC4899),
                    title: 'Broadcast Center',
                    subtitle: 'Send push notifications',
                    onTap: () => context.push('/admin-notifications'),
                  ),
                  _divider(context),
                  _buildActionRow(
                    context: context,
                    icon: Icons.bar_chart_rounded,
                    iconColor: const Color(0xFF6366F1),
                    title: 'Revenue Analytics',
                    subtitle: 'View earnings and charts',
                    onTap: () => context.push('/admin-revenue'),
                  ),
                ]),

                SizedBox(height: 24.h),
                _buildSectionLabel('Account'),
                SizedBox(height: 10.h),
                _buildCard(children: [
                  _buildActionRow(
                    context: context,
                    icon: Icons.logout_rounded,
                    iconColor: const Color(0xFFEF4444),
                    title: 'Log Out',
                    subtitle: 'Sign out of admin account',
                    textColor: const Color(0xFFEF4444),
                    showArrow: false,
                    onTap: () => context.read<AuthBloc>().add(LogoutRequested()),
                  ),
                ]),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.dividerColor),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 36.r,
                backgroundColor: context.primaryColor.withOpacity(0.1),
                backgroundImage: _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
                child: _avatarUrl == null && !_isUploadingAvatar
                    ? Icon(Icons.shield_rounded, size: 32.sp, color: context.primaryColor)
                    : _isUploadingAvatar
                        ? const CircularProgressIndicator(strokeWidth: 2)
                        : null,
              ),
              Positioned(
                bottom: 0, right: 0,
                child: GestureDetector(
                  onTap: _pickAndUploadAvatar,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(color: context.primaryColor, shape: BoxShape.circle, border: Border.all(color: context.backgroundColor, width: 2)),
                    child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 14.sp),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Admin User', style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
                SizedBox(height: 2.h),
                Text('System Administrator', style: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: context.textSecondaryColor)),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(color: context.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20.r)),
                  child: Text('Super Admin', style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp, fontWeight: FontWeight.w700, color: context.primaryColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickAndUploadAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() => _isUploadingAvatar = true);
    try {
      final uploader = getIt<CloudinaryService>();
      final url = await uploader.uploadProfileImage(File(pickedFile.path), 'admin_avatar');
      setState(() => _avatarUrl = url);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Avatar updated successfully')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      if (mounted) setState(() => _isUploadingAvatar = false);
    }
  }

  Widget _buildSectionLabel(String title) {
    return Text(title.toUpperCase(), style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, fontWeight: FontWeight.w700, color: context.textSecondaryColor, letterSpacing: 0.8));
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.dividerColor),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8)],
      ),
      child: Column(children: children),
    );
  }

  Widget _divider(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Divider(color: context.dividerColor, height: 1),
  );

  Widget _buildToggleRow({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
            child: Icon(icon, color: iconColor, size: 20.sp),
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
          Switch.adaptive(value: value, onChanged: onChanged, activeColor: iconColor),
        ],
      ),
    );
  }

  Widget _buildActionRow({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w600, color: textColor ?? context.textPrimaryColor)),
                  Text(subtitle, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
                ],
              ),
            ),
            if (showArrow) Icon(Icons.arrow_forward_ios_rounded, size: 14.sp, color: context.textSecondaryColor),
          ],
        ),
      ),
    );
  }
}
