import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool isDestructive;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.iconColor,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? Colors.red.withValues(alpha: 0.1)
                        : (iconColor ?? theme.primaryColor).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 22.sp,
                    color: isDestructive ? Colors.red : (iconColor ?? theme.primaryColor),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDestructive ? Colors.red : theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14.sp,
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.3),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
