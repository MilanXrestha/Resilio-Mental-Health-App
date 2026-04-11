import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/theme/app_colors.dart';

/// Single shimmer pass; child blocks are flat white shapes (no nested Shimmer).
class DashboardShimmerLoading extends StatelessWidget {
  const DashboardShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header — matches [_Header]: avatar ring ~58, greeting, notification bell
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
              child: Row(
                children: [
                  Container(
                    width: 58.w,
                    height: 58.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200.w,
                          height: 26.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          width: 120.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Daily Inspiration — SectionHeader + carousel
            const _SectionTitleSkeleton(
              titleWidth: 180,
              subtitleWidth: 240,
            ),
            SizedBox(height: 16.h),
            Container(
              height: 200.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            SizedBox(height: 36.h),

            // Categories
            _HorizontalSectionSkeleton(
              listHeight: 210,
              cardWidth: 145,
              titleWidth: 170,
              subtitleWidth: 220,
              cardRadius: 16,
              itemCount: 4,
              gap: 14,
            ),
            SizedBox(height: 36.h),

            // Therapy hook card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 132.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(height: 36.h),

            // Reminders card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 120.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            SizedBox(height: 40.h),

            // Calming Audio
            _HorizontalSectionSkeleton(
              listHeight: 190,
              cardWidth: 310,
              titleWidth: 150,
              subtitleWidth: 260,
              cardRadius: 16,
              itemCount: 3,
              gap: 16,
            ),
            SizedBox(height: 36.h),

            // Short Videos
            _HorizontalSectionSkeleton(
              listHeight: 245,
              cardWidth: 160,
              titleWidth: 130,
              subtitleWidth: 200,
              cardRadius: 16,
              itemCount: 4,
              gap: 14,
            ),
            SizedBox(height: 36.h),

            // Tips
            _HorizontalSectionSkeleton(
              listHeight: 280,
              cardWidth: 260,
              titleWidth: 140,
              subtitleWidth: 240,
              cardRadius: 16,
              itemCount: 3,
              gap: 16,
            ),
            SizedBox(height: 36.h),

            // Inspirational Images
            _HorizontalSectionSkeleton(
              listHeight: 280,
              cardWidth: 150,
              titleWidth: 200,
              subtitleWidth: 260,
              cardRadius: 16,
              itemCount: 4,
              gap: 16,
            ),
            SizedBox(height: 36.h),

            // More Quotes
            _HorizontalSectionSkeleton(
              listHeight: 145,
              cardWidth: 260,
              titleWidth: 120,
              subtitleWidth: 260,
              cardRadius: 14,
              itemCount: 4,
              gap: 14,
            ),
            SizedBox(height: 36.h),

            // Featured Videos (long)
            _HorizontalSectionSkeleton(
              listHeight: 300,
              cardWidth: 320,
              titleWidth: 160,
              subtitleWidth: 220,
              cardRadius: 16,
              itemCount: 3,
              gap: 16,
            ),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }
}

class _SectionTitleSkeleton extends StatelessWidget {
  final double titleWidth;
  final double subtitleWidth;

  const _SectionTitleSkeleton({
    required this.titleWidth,
    required this.subtitleWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: titleWidth.w,
            height: 22.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: subtitleWidth.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}

class _HorizontalSectionSkeleton extends StatelessWidget {
  final double listHeight;
  final double cardWidth;
  final double titleWidth;
  final double subtitleWidth;
  final double cardRadius;
  final int itemCount;
  final double gap;

  const _HorizontalSectionSkeleton({
    required this.listHeight,
    required this.cardWidth,
    required this.titleWidth,
    required this.subtitleWidth,
    required this.cardRadius,
    this.itemCount = 4,
    this.gap = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitleSkeleton(
          titleWidth: titleWidth,
          subtitleWidth: subtitleWidth,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: listHeight.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            separatorBuilder: (_, _) => SizedBox(width: gap.w),
            itemBuilder: (_, __) => Container(
              width: cardWidth.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(cardRadius.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Standalone shimmer block (e.g. short-video section while bloc loads).
class SectionShimmerLoading extends StatelessWidget {
  final double height;
  final double width;

  const SectionShimmerLoading({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final baseColor = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: _HorizontalSectionSkeleton(
        listHeight: height,
        cardWidth: width,
        titleWidth: 140,
        subtitleWidth: 200,
        cardRadius: 16,
        itemCount: 4,
        gap: 16,
      ),
    );
  }
}
