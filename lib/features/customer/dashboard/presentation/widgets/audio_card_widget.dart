import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routing/route_names.dart';
import '../../../../../core/services/media_duration_cache.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/media_duration_resolver.dart';
import '../../../../../core/widgets/premium_tag_widget.dart';
import '../../../audio/domain/entities/audio_entity.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../../subscription/presentation/bloc/subscription_bloc.dart';
import '../../../subscription/presentation/bloc/subscription_state.dart';

/// Beautiful audio card widget for displaying audio tracks in horizontal list
class AudioCardWidget extends StatelessWidget {
  final AudioEntity track;
  final VoidCallback? onTap;

  const AudioCardWidget({
    super.key,
    required this.track,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        if (track.isPremium) {
          final state = context.read<SubscriptionBloc>().state;
          final isPremiumUser = state is SubscriptionLoaded && state.subscription.isActive;
          if (!isPremiumUser) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Premium subscription required to play this content.')),
            );
            context.pushNamed(RouteNames.subscription);
            return;
          }
        }
        if (onTap != null) onTap!();
      },
      child: Container(
        width: 300.w,
        height: 150.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [context.surfaceColor, context.surfaceColor.withValues(alpha: 0.9)]
                : [Colors.white, context.surfaceColor],
          ),
          boxShadow: [
            BoxShadow(
              color: isDarkMode 
                  ? Colors.black.withValues(alpha: 0.3) 
                  : Colors.black.withValues(alpha: 0.08),
              offset: Offset(0, 2.h),
              blurRadius: 6.r,
              spreadRadius: isDarkMode ? 0.5.r : 0.r,
            ),
          ],
          border: Border.all(
            color: context.borderColor.withValues(alpha: 0.3),
            width: isDarkMode ? 1.5.w : 1.w,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Multiple music note backgrounds for pure aesthetics
              Positioned(
                right: 5.w,
                bottom: -5.h,
                child: Opacity(
                  opacity: isDarkMode ? 0.05 : 0.09,
                  child: Icon(
                    Icons.music_note_rounded,
                    size: 140.sp,
                    color: context.primaryColor,
                  ),
                ),
              ),
              Positioned(
                right: 5.w,
                top: 50.h,
                child: Opacity(
                  opacity: isDarkMode ? 0.05 : 0.09,
                  child: Icon(
                    Icons.music_note_rounded,
                    size: 60.sp,
                    color: context.primaryColor,
                  ),
                ),
              ),
              
              // Main content
              Padding(
                padding: EdgeInsets.all(12.r),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Circular Thumbnail
                    Container(
                      width: 95.w,
                      height: 95.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDarkMode
                              ? [context.surfaceColor, context.backgroundColor]
                              : [context.surfaceColor, Colors.white],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.primaryColor.withValues(alpha: 0.1),
                            blurRadius: 8.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: track.coverImageUrl.isNotEmpty
                            ? Image.network(
                                track.coverImageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(
                                  Icons.music_note_rounded,
                                  color: context.primaryColor.withValues(alpha: 0.5),
                                  size: 36.sp,
                                ),
                              )
                            : Icon(
                                Icons.music_note_rounded,
                                color: context.primaryColor.withValues(alpha: 0.5),
                                size: 36.sp,
                              ),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    // Text content and play button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            track.title,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: context.textPrimaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mic_none_rounded,
                                size: 15.w,
                                color: context.textSecondaryColor,
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  track.artistName,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13.sp,
                                    color: context.textPrimaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),

                          // Play button badge
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  context.primaryColor,
                                  context.primaryColor.withValues(alpha: 0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: context.primaryColor.withValues(alpha: 0.2),
                                  blurRadius: 4.r,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Play',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Favorite Button (Top Right)
              Positioned(
                top: 8.h,
                right: 8.w,
                child: FavoriteButton(
                  contentId: track.id,
                  contentType: FavoriteType.audio,
                ),
              ),

              // Premium Tag (Top Left)
              PremiumTagWidget(
                isPremium: track.isPremium,
                top: 8,
                left: 8,
              ),

              // Duration chip — uses DB value, else probes the audio.
              Positioned(
                bottom: 12.h,
                right: 12.w,
                child: MediaDurationResolver(
                  url: track.audioUrl,
                  fallbackSeconds: track.durationSeconds,
                  kind: MediaKind.audio,
                  builder: (context, label) {
                    if (label == null) return const SizedBox.shrink();
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? context.surfaceColor.withValues(alpha: 0.9)
                            : Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: context.primaryColor.withValues(alpha: 0.2),
                          width: 1.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4.r,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 12.sp,
                            color: context.primaryColor,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            label,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: context.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
