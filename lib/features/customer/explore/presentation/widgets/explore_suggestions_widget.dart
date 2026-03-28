import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class ExploreSuggestionsWidget extends StatelessWidget {
  final List<String> recentSearches;
  final List<String> trendingSearches;
  final ValueChanged<String> onSuggestionTap;
  final VoidCallback? onClearRecent;

  const ExploreSuggestionsWidget({
    super.key,
    required this.recentSearches,
    required this.trendingSearches,
    required this.onSuggestionTap,
    this.onClearRecent,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent searches
          if (recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Searches',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                if (onClearRecent != null)
                  TextButton(
                    onPressed: onClearRecent,
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: context.primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: recentSearches.map((search) {
                return _SuggestionChip(
                  label: search,
                  icon: Icons.history_rounded,
                  onTap: () => onSuggestionTap(search),
                );
              }).toList(),
            ),
            SizedBox(height: 28.h),
          ],

          // Trending searches
          if (trendingSearches.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.trending_up_rounded,
                  size: 20.sp,
                  color: context.primaryColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Trending',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: trendingSearches.map((search) {
                return _SuggestionChip(
                  label: search,
                  isTrending: true,
                  onTap: () => onSuggestionTap(search),
                );
              }).toList(),
            ),
          ],

          SizedBox(height: 32.h),

          // Quick categories
          Text(
            'Browse by Type',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _QuickCategoryItem(
                icon: Icons.headphones_rounded,
                label: 'Audio',
                color: const Color(0xFF6366F1),
                onTap: () => onSuggestionTap('audio'),
              ),
              _QuickCategoryItem(
                icon: Icons.play_circle_rounded,
                label: 'Videos',
                color: const Color(0xFFEC4899),
                onTap: () => onSuggestionTap('video'),
              ),
              _QuickCategoryItem(
                icon: Icons.format_quote_rounded,
                label: 'Quotes',
                color: const Color(0xFF0D9488),
                onTap: () => onSuggestionTap('quote'),
              ),
              _QuickCategoryItem(
                icon: Icons.lightbulb_rounded,
                label: 'Tips',
                color: const Color(0xFFF59E0B),
                onTap: () => onSuggestionTap('tip'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isTrending;
  final VoidCallback onTap;

  const _SuggestionChip({
    required this.label,
    this.icon,
    this.isTrending = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isTrending
              ? context.primaryColor.withOpacity(0.1)
              : context.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isTrending
                ? context.primaryColor.withOpacity(0.3)
                : context.borderColor.withOpacity(0.3),
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16.sp,
                color: context.textSecondaryColor,
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: isTrending
                    ? context.primaryColor
                    : context.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickCategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickCategoryItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: color.withOpacity(0.2),
                width: 1.5.w,
              ),
            ),
            child: Icon(
              icon,
              size: 28.sp,
              color: color,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}