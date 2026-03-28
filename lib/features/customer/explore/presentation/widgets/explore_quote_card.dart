import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/explore_item_entity.dart';

class ExploreQuoteCard extends StatelessWidget {
  final ExploreItemEntity item;
  final int gradientIndex;
  final VoidCallback? onTap;

  const ExploreQuoteCard({
    super.key,
    required this.item,
    required this.gradientIndex,
    this.onTap,
  });

  static const _gradients = <List<Color>>[
    [Color(0xFF0D9488), Color(0xFF0F766E)],
    [Color(0xFF6366F1), Color(0xFF4F46E5)],
    [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
    [Color(0xFF0EA5E9), Color(0xFF0284C7)],
    [Color(0xFF059669), Color(0xFF047857)],
    [Color(0xFFD97706), Color(0xFFB45309)],
    [Color(0xFFDB2777), Color(0xFFBE185D)],
  ];

  @override
  Widget build(BuildContext context) {
    final colors = _gradients[gradientIndex % _gradients.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280.w,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: colors.first.withOpacity(0.4),
              blurRadius: 16.r,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.format_quote_rounded,
              size: 28.sp,
              color: Colors.white.withOpacity(0.4),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: Text(
                '"${item.title}"',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            if (item.subtitle != null)
              Text(
                '— ${item.subtitle}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
          ],
        ),
      ),
    );
  }
}