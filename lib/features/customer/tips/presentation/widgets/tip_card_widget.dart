import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/tip_entity.dart';

class TipCardWidget extends StatelessWidget {
  final TipEntity tip;
  final VoidCallback? onTap;

  const TipCardWidget({
    super.key,
    required this.tip,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _getGradientColorForType(context),
                _getGradientColorForType(context).withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with type badge
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        tip.tipTypeString,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (tip.isFeatured) ...[
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.star_rounded,
                      color: Colors.amber.shade300,
                      size: 24.r,
                    ),
                  ],
                ],
              ),

              SizedBox(height: 12.h),

              // Title
              Text(
                tip.title,
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 8.h),

              // Tip text preview
              Text(
                tip.tipText,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 16.h),

              // Author info
              Row(
                children: [
                  if (tip.authorIconUrl.isNotEmpty) ...[
                    CircleAvatar(
                      radius: 14.r,
                      backgroundImage: NetworkImage(tip.authorIconUrl),
                      onBackgroundImageError: (_, __) => null,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  Expanded(
                    child: Text(
                      tip.author.isNotEmpty ? tip.author : 'Unknown',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Get gradient color based on tip type
  Color _getGradientColorForType(BuildContext context) {
    switch (tip.tipType) {
      case TipType.relationshipBooster:
        return const Color(0xFFFF6B6B); // Coral red
      case TipType.lettingGo:
        return const Color(0xFF4ECDC4); // Teal
      case TipType.communication:
        return const Color(0xFFFFE66D); // Yellow (darker for contrast)
      case TipType.selfCare:
        return const Color(0xFF95E1D3); // Mint green
      case TipType.mindfulness:
        return const Color(0xFFA8E6CF); // Light green
      case TipType.general:
        return context.primaryColor;
      case TipType.unknown:
        return Colors.grey.shade600;
    }
  }
}
