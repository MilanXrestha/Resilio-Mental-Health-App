import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Resilio/core/theme/app_colors.dart';

class AdminStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final Color? bgColor;
  final VoidCallback? onTap;

  const AdminStatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.bgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? context.primaryColor;
    final bg = bgColor ?? color.withOpacity(0.08);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: context.dividerColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14.r)),
                  child: Icon(icon, color: color, size: 22.sp),
                ),
                if (onTap != null)
                  Icon(Icons.arrow_forward_ios_rounded, color: context.textSecondaryColor, size: 14.sp),
              ],
            ),
            const Spacer(),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: context.textPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: context.textSecondaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (subtitle != null) ...[
              SizedBox(height: 2.h),
              Text(
                subtitle!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.sp,
                  color: context.textHintColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AdminSectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const AdminSectionHeader({super.key, required this.title, this.action, this.onAction});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: context.textPrimaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (action != null) ...[
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onAction,
            child: Text(
              action!,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: context.primaryColor,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class AdminEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const AdminEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: context.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(icon, size: 40.sp, color: context.primaryColor.withOpacity(0.5)),
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              SizedBox(height: 8.h),
              Text(
                subtitle!,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  color: context.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add_rounded, color: Colors.white),
                label: Text(actionLabel!, style: const TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AdminSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const AdminSearchBar({
    super.key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp, color: context.textHintColor),
        prefixIcon: Icon(Icons.search_rounded, size: 20.sp, color: context.textSecondaryColor),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear_rounded, size: 18.sp),
                onPressed: () {
                  controller.clear();
                  onClear?.call();
                },
              )
            : null,
        filled: true,
        fillColor: context.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
      ),
      onChanged: onChanged,
    );
  }
}

class AdminFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? selectedColor;

  const AdminFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = selectedColor ?? context.primaryColor;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? color : context.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: isSelected ? color : context.borderColor, width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : context.textSecondaryColor,
          ),
        ),
      ),
    );
  }
}

class AdminStatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const AdminStatusBadge({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
