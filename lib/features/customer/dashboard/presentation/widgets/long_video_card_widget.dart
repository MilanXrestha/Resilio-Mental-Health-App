import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../video/domain/entities/video_entity.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';

/// Beautiful long video card widget (16:9 aspect ratio)
class LongVideoCardWidget extends StatelessWidget {
  final VideoEntity video;
  final VoidCallback? onTap;

  const LongVideoCardWidget({
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
        width: 290.w,
        margin: EdgeInsets.only(right: 10.w),
        child: ClipRect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail with play button and duration
              Stack(
                children: [
                  Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: isDarkMode ? context.surfaceColor : Colors.white,
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
                      child: video.coverImageUrl.isNotEmpty
                          ? Image.network(
                              video.coverImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildPlaceholder(context, isDarkMode),
                            )
                          : _buildPlaceholder(context, isDarkMode),
                    ),
                  ),
                  
                  // Play button overlay
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withValues(alpha: 0.6),
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                    ),
                  ),

                  // Duration chip
                  if (video.formattedDuration.isNotEmpty)
                    Positioned(
                      bottom: 10.h,
                      right: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          video.formattedDuration,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 12.h),

              // Info section matching reference
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Artist avatar
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: context.primaryColor.withValues(alpha: 0.15),
                    child: Text(
                      video.artistName.isNotEmpty 
                        ? video.artistName[0].toUpperCase() 
                        : '?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: context.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  // Title and metadata
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Text(
                              video.artistName,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                color: context.textSecondaryColor,
                              ),
                            ),
                            Text(
                              ' • ',
                              style: TextStyle(
                                color: context.textSecondaryColor,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              '${_formatViewCount(video.playCount)} views',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                color: context.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FavoriteButton(
                    contentId: video.id,
                    contentType: FavoriteType.video,
                    color: context.textSecondaryColor,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ],
          ),
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
          size: 40.sp,
          color: context.textSecondaryColor.withValues(alpha: 0.5),
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
