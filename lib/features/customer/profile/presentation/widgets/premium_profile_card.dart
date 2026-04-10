import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Resilio/features/customer/profile/domain/entities/profile_entity.dart';
import 'package:Resilio/features/customer/profile/presentation/widgets/diamond_pattern_painter.dart';

class PremiumProfileCard extends StatelessWidget {
  final ProfileEntity profile;
  final String planName;

  const PremiumProfileCard({
    super.key,
    required this.profile,
    required this.planName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF000000), // Deep black
            Color(0xFF141414), // Rich black
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10.r,
            spreadRadius: 1.r,
            offset: Offset(0, 4.h),
          ),
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
          width: 1.w,
        ),
      ),
      child: Stack(
        children: [
          // Diamond pattern background
          Positioned.fill(
            child: CustomPaint(
              painter: DiamondPatternPainter(),
            ),
          ),

          // Card content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row with plan badge and logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Premium badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFD4AF37), // Gold
                            Color(0xFFB8860B), // Dark gold
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.2),
                            blurRadius: 30.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.diamond,
                            size: 10.sp,
                            color: Colors.black,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            planName.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // App Logo or Name (Simplified)
                    Text(
                      'RESILIO',
                      style: TextStyle(
                        color: const Color(0xFFD4AF37),
                        fontWeight: FontWeight.w900,
                        fontSize: 14.sp,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // User details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.displayName.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'MEMBER SINCE ${profile.createdAt.year}',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Small QR-like or chip icon for aesthetic
                    Icon(
                      Icons.qr_code_2_rounded,
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
                      size: 32.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
