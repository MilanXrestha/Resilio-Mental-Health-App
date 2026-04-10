import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/theme/app_colors.dart';

class DashboardShimmerLoading extends StatelessWidget {
  const DashboardShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

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
          // Header Shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 52.r,
                  height: 52.r,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 14.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 110.w, height: 26.h, color: Colors.white),
                    SizedBox(height: 6.h),
                    Container(width: 150.w, height: 14.h, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 28.h),
          
          // Quotes Shimmer
          Container(
            height: 200.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
          SizedBox(height: 36.h),

          // Categories Shimmer
          const SectionShimmerLoading(height: 180, width: 145),
          SizedBox(height: 36.h),

          // Audio Shimmer
          const SectionShimmerLoading(height: 135, width: 310),
        ],
        ),
      ),
    );
  }
}

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
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 140.w, height: 22.h, color: Colors.white),
                SizedBox(height: 8.h),
                Container(width: 200.w, height: 14.h, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: height.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (_, __) => SizedBox(width: 16.w),
              itemBuilder: (_, __) => Container(
                width: width.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
