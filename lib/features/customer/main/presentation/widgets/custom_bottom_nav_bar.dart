import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/theme_extension.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final List<IconData> _icons = const [
    Icons.home_rounded,
    FontAwesomeIcons.compass,
    FontAwesomeIcons.video,
    FontAwesomeIcons.layerGroup,
    Icons.favorite_rounded,
  ];

  final List<String> _labels = const [
    'Home',
    'Explore',
    'Shorts',
    'Category',
    'Favorite',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: context.navBarBackgroundColor,
        border: Border.all(
          color: context.navBarBorderColor,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.navBarShadow.of(context),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          decoration: BoxDecoration(
            color: context.navBarBackgroundColor,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            children: List.generate(_icons.length, (index) {
              final bool isSelected = index == selectedIndex;

              if (isSelected) {
                return _buildSelectedItem(context, index);
              } else {
                return _buildUnselectedItem(context, index);
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedItem(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: GestureDetector(
        onTap: () => onItemTapped(index),
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: context.navBarChipColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipOval(
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  alignment: Alignment.center,
                  color: context.primaryColor,
                  child: Icon(
                    _icons[index],
                    size: index == 0 ? 22.sp : 18.sp,
                    color: context.navBarSelectedIconColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  _labels[index],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnselectedItem(BuildContext context, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onItemTapped(index),
        behavior: HitTestBehavior.translucent,
        child: Container(
          alignment: Alignment.center,
          child: ClipOval(
            child: Container(
              width: 36.w,
              height: 36.h,
              alignment: Alignment.center,
              color: context.navBarUnselectedIconBgColor,
              child: Icon(
                _icons[index],
                size: index == 0 ? 22.sp : 20.sp,
                color: context.textSecondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}