import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumTagWidget extends StatelessWidget {
  final bool isPremium;
  final double top;
  final double? right;
  final double? left;
  final double padding;

  const PremiumTagWidget({
    super.key,
    required this.isPremium,
    this.top = 8,
    this.right,
    this.left,
    this.padding = 6,
  });

  @override
  Widget build(BuildContext context) {
    if (!isPremium) return const SizedBox.shrink();

    return Positioned(
      top: top.h,
      right: right?.w,
      left: left?.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: padding.w, vertical: padding.h / 1.5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFFFDB931)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star_rounded,
              color: Colors.white,
              size: 12.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              'PRO',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
