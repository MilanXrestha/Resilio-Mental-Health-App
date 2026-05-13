import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:Resilio/core/theme/app_colors.dart';

class AdminMoreScreen extends StatelessWidget {
  const AdminMoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        title: Text('More', style: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.w700, color: context.textPrimaryColor)),
        backgroundColor: context.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildMenuItem(
              context: context,
              icon: Icons.notifications_active_rounded,
              title: 'Push Notifications',
              subtitle: 'Broadcast messages to users and therapists',
              color: const Color(0xFFF59E0B),
              onTap: () => context.push('/admin-notifications'), // Need to add routing
            ),
            SizedBox(height: 12.h),
            _buildMenuItem(
              context: context,
              icon: Icons.app_settings_alt_rounded,
              title: 'Preferences Config',
              subtitle: 'Manage user onboarding options',
              color: const Color(0xFF10B981),
              onTap: () => context.push('/admin-preferences'), // Need to add routing
            ),
            SizedBox(height: 12.h),
            _buildMenuItem(
              context: context,
              icon: Icons.paid_rounded,
              title: 'Revenue Analytics',
              subtitle: 'View detailed charts and payouts',
              color: const Color(0xFF0D9488),
              onTap: () => context.push('/admin-revenue'), // Need to add routing
            ),
            SizedBox(height: 24.h),
            Divider(color: context.dividerColor),
            SizedBox(height: 24.h),
            _buildMenuItem(
              context: context,
              icon: Icons.settings_rounded,
              title: 'Settings',
              subtitle: 'Theme, Access, and Logs',
              color: const Color(0xFF6366F1),
              onTap: () => context.push('/admin-settings'), 
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
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
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 15.sp, fontWeight: FontWeight.w600, color: context.textPrimaryColor)),
                  Text(subtitle, style: TextStyle(fontFamily: 'Poppins', fontSize: 11.sp, color: context.textSecondaryColor)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: context.textSecondaryColor, size: 14.sp),
          ],
        ),
      ),
    );
  }
}
