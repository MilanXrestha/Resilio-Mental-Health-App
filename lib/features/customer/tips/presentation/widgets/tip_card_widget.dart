import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/tip_entity.dart';
import '../../../../../core/theme/theme_extension.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';

class TipCardWidget extends StatelessWidget {
  final TipEntity tip;
  final VoidCallback onTap;

  const TipCardWidget({
    super.key,
    required this.tip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    final baseColor = _getGradientColorForType(context, tip.tipType);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            isDarkMode ? context.surfaceColor : Colors.white,
            isDarkMode 
                ? Color.lerp(context.surfaceColor, baseColor, 0.05)!
                : Color.lerp(Colors.white, baseColor, 0.08)!,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: baseColor.withOpacity(isDarkMode ? 0.08 : 0.15),
            blurRadius: 16.r,
            offset: Offset(0, 8.h),
          ),
        ],
        border: Border.all(
          color: baseColor.withOpacity(isDarkMode ? 0.3 : 0.4),
          width: 1.2.w,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              // Rich angled background gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        baseColor.withOpacity(isDarkMode ? 0.15 : 0.1),
                        Colors.transparent,
                        baseColor.withOpacity(isDarkMode ? 0.05 : 0.02),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),

              // Giant watermark icon in the bottom right
              Positioned(
                right: -25.w,
                bottom: -20.h,
                child: Transform.rotate(
                  angle: -0.2,
                  child: Opacity(
                    opacity: isDarkMode ? 0.08 : 0.06,
                    child: Icon(
                      _getIconForType(tip.tipType),
                      size: 160.sp,
                      color: baseColor,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Glassmorphic Badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: baseColor.withOpacity(isDarkMode ? 0.2 : 0.15),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: baseColor.withOpacity(0.3),
                          width: 0.5.w,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getIconForType(tip.tipType),
                            size: 12.sp,
                            color: isDarkMode ? baseColor : baseColor.withOpacity(0.9),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            tip.tipTypeString.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: isDarkMode ? baseColor : baseColor.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Title
                    Text(
                      tip.title,
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: context.textPrimaryColor,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),

                    // Preview Text (Informative)
                    Expanded(
                      child: Text(
                        tip.tipText,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: context.textSecondaryColor,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Author line with subtle accent line
                    if (tip.author.isNotEmpty) ...[
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Container(
                            width: 24.w,
                            height: 2.h,
                            decoration: BoxDecoration(
                              color: baseColor,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'By ${tip.author}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: baseColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(TipType tipType) {
    switch (tipType) {
      case TipType.relationshipBooster:
        return Icons.favorite_rounded;
      case TipType.lettingGo:
        return Icons.water_drop_rounded;
      case TipType.communication:
        return Icons.chat_bubble_rounded;
      case TipType.selfCare:
        return Icons.spa_rounded;
      case TipType.mindfulness:
        return Icons.self_improvement_rounded;
      case TipType.general:
        return Icons.lightbulb_rounded;
      case TipType.unknown:
        return Icons.article_rounded;
    }
  }

  Color _getGradientColorForType(BuildContext context, TipType tipType) {
    switch (tipType) {
      case TipType.relationshipBooster:
        return const Color(0xFFFF6B6B);
      case TipType.lettingGo:
        return const Color(0xFF4ECDC4);
      case TipType.communication:
        return const Color(0xFFFFE66D);
      case TipType.selfCare:
        return const Color(0xFF95E1D3);
      case TipType.mindfulness:
        return const Color(0xFFA8E6CF);
      case TipType.general:
        return context.primaryColor;
      case TipType.unknown:
        return Colors.grey.shade500;
    }
  }
}
