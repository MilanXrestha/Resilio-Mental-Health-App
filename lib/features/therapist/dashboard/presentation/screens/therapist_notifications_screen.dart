import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/theme/app_colors.dart';

class TherapistNotificationsScreen extends StatelessWidget {
  const TherapistNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For now we'll just mock it directly in UI 
    // to instantly satisfy the "make notification screen" goal.
    final mockNotifications = [
      {
        'title': 'New Patient Request',
        'body': 'Sarah Jenkins has requested a session for tomorrow.',
        'time': '10 mins ago',
        'isUnread': true,
        'icon': Icons.person_add_rounded,
        'color': context.primaryColor,
      },
      {
        'title': 'Payment Received',
        'body': 'Rs.50.00 transferred successfully to your account.',
        'time': '2 hours ago',
        'isUnread': true,
        'icon': Icons.payments_rounded,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'System Update',
        'body': 'Therapist Dashboard v2.0 is now live!',
        'time': 'Yesterday',
        'isUnread': false,
        'icon': Icons.system_update_rounded,
        'color': const Color(0xFF6366F1),
      },
    ];

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: context.textPrimaryColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: context.textPrimaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Mark all read',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: context.primaryColor,
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        itemCount: mockNotifications.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, i) {
          final n = mockNotifications[i];
          final isUnread = n['isUnread'] as bool;
          final color = n['color'] as Color;

          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isUnread
                  ? color.withOpacity(0.05)
                  : context.surfaceColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isUnread
                    ? color.withOpacity(0.2)
                    : context.borderColor,
                width: 0.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(n['icon'] as IconData, color: color, size: 20.sp),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              n['title'] as String,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                fontWeight: isUnread
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                color: context.textPrimaryColor,
                              ),
                            ),
                          ),
                          Text(
                            n['time'] as String,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.sp,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        n['body'] as String,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          color: isUnread
                              ? context.textPrimaryColor
                              : context.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isUnread) ...[
                  SizedBox(width: 8.w),
                  Container(
                    margin: EdgeInsets.only(top: 6.h),
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
