import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../video/domain/entities/video_entity.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';

/// Beautiful short video card widget (9:16 aspect ratio - TikTok/Reels style)
class ShortVideoCardWidget extends StatelessWidget {
  final VideoEntity video;
  final VoidCallback? onTap;

  const ShortVideoCardWidget({
    super.key,
    required this.video,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        margin: EdgeInsets.only(right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: isDarkMode
                        ? context.surfaceColor
                        : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: video.thumbnailUrl.isNotEmpty
                        ? Image.network(
                            video.thumbnailUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _buildPlaceholder(context, isDarkMode),
                          )
                        : _buildPlaceholder(context, isDarkMode),
                  ),
                ),
                
                // Short label badge
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      'REELS',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                // Favorite Button
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: FavoriteButton(
                    contentId: video.id,
                    contentType: FavoriteType.video,
                    size: 18.sp,
                  ),
                ),
                
                // Play button overlay
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: 0.5),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1.5.w,
                        ),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
                
                // Duration chip
                if (video.formattedDuration.isNotEmpty)
                  Positioned(
                    bottom: 8.h,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        video.formattedDuration,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                // View count chip
                Positioned(
                  bottom: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 10.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          _formatViewCount(video.playCount), // Mapping playCount to view count
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context, bool isDarkMode) {
    return Container(
      color: isDarkMode ? Colors.grey[900] : Colors.grey[200],
      child: Center(
        child: Icon(
          Icons.videocam_rounded,
          size: 30.sp,
          color: isDarkMode
              ? context.textSecondaryColor
              : context.textSecondaryColor,
        ),
      ),
    );
  }

  String _formatViewCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
}
