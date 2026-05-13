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
  String? _avatarUrl; // We would ideally read this from auth state

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
              'App Settings',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor),
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

                _buildSectionHeader('Appearance & Language'),
                SizedBox(height: 12.h),
                _buildSettingCard(
                  children: [
                    _buildToggleSetting(
                      icon: Icons.dark_mode_rounded,
                      iconColor: const Color(0xFF8B5CF6),
                      title: 'Dark Mode',
                      subtitle: 'Switch application theme',
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
                      subtitle: 'Toggle localized strings',
                      value: isNepali,
                      onChanged: (val) {
                        context.read<ThemeCubit>().toggleLocale();
                      },
                    ),
                  ],
                ),
                
                SizedBox(height: 24.h),
                _buildSectionHeader('Platform Management'),
                SizedBox(height: 12.h),
                _buildSettingCard(
                  children: [
                    _buildActionSetting(
                      icon: Icons.app_settings_alt_rounded,
                      iconColor: const Color(0xFFF59E0B),
                      title: 'Onboarding Preferences',
                      onTap: () => context.push('/admin-preferences'),
                    ),
                    Divider(color: context.dividerColor, height: 1),
                    _buildActionSetting(
                      icon: Icons.notifications_active_rounded,
                      iconColor: const Color(0xFFEC4899),
                      title: 'Broadcasts Log',
                      onTap: () => context.push('/admin-notifications'),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),
                _buildSectionHeader('Account Actions'),
                SizedBox(height: 12.h),
                _buildSettingCard(
                  children: [
                    _buildActionSetting(
                      icon: Icons.logout_rounded,
                      iconColor: const Color(0xFFEF4444),
                      title: 'Log Out',
                      textColor: const Color(0xFFEF4444),
                      showArrow: false,
                      onTap: () {
                        context.read<AuthBloc>().add(LogoutRequested());
                      },
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 48.r,
                backgroundColor: context.primaryColor.withOpacity(0.1),
                backgroundImage: _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
                child: _avatarUrl == null && !_isUploadingAvatar
                    ? Icon(Icons.shield_rounded, size: 40.sp, color: context.primaryColor)
                    : _isUploadingAvatar
                        ? const CircularProgressIndicator()
                        : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickAndUploadAvatar,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: context.backgroundColor, width: 3),
                    ),
                    child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16.sp),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text('Admin User', style: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
          Text('System Administrator', style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textSecondaryColor)),
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
      // Using generic admin_avatar key for this demo.
      final url = await uploader.uploadProfileImage(File(pickedFile.path), 'admin_avatar');
      setState(() => _avatarUrl = url);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Avatar updated successfully')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isUploadingAvatar = false);
    }
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, fontWeight: FontWeight.w700, color: context.textSecondaryColor));
  }

  Widget _buildSettingCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildToggleSetting({
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
          SizedBox(width: 16.w),
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

  Widget _buildActionSetting({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10.r)),
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(child: Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w600, color: textColor ?? context.textPrimaryColor))),
            if (showArrow) Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: context.textSecondaryColor),
          ],
        ),
      ),
    );
  }
}
