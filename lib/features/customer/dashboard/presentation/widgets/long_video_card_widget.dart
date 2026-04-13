import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/premium_tag_widget.dart';
import '../../../video/domain/entities/video_entity.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../../subscription/presentation/bloc/subscription_bloc.dart';
import '../../../subscription/presentation/bloc/subscription_state.dart';

// Per-session cache shared across all long video cards.
final Map<String, Uint8List?> _longVideoThumbnailCache = {};

/// Beautiful long video card widget (16:9 aspect ratio).
/// Generates a thumbnail from the video URL (same approach as ShortVideoCardWidget),
/// falling back to coverImageUrl / thumbnailUrl if generation fails.
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
      onTap: () {
        if (video.isPremium) {
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
                    height: 190.h,
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
                      child: _LongVideoThumbnail(
                        videoUrl: video.videoUrl,
                        fallbackUrl: video.coverImageUrl.isNotEmpty
                            ? video.coverImageUrl
                            : video.thumbnailUrl,
                        isDarkMode: isDarkMode,
                      ),
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

                  // Premium Tag
                  PremiumTagWidget(
                    isPremium: video.isPremium,
                    top: 8,
                    left: 8,
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Info row
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
                            // Text(
                            //   ' • ',
                            //   style: TextStyle(
                            //     color: context.textSecondaryColor,
                            //     fontSize: 12.sp,
                            //   ),
                            // ),
                            // Text(
                            //   '${_formatViewCount(video.playCount)} views',
                            //   style: TextStyle(
                            //     fontFamily: 'Poppins',
                            //     fontSize: 12.sp,
                            //     color: context.textSecondaryColor,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
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

  String _formatViewCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Internal thumbnail widget — generates from video URL via video_thumbnail,
// with in-memory caching and CachedNetworkImage fallback.
// ─────────────────────────────────────────────────────────────────────────────

class _LongVideoThumbnail extends StatefulWidget {
  final String videoUrl;
  final String fallbackUrl;
  final bool isDarkMode;

  const _LongVideoThumbnail({
    required this.videoUrl,
    required this.fallbackUrl,
    required this.isDarkMode,
  });

  @override
  State<_LongVideoThumbnail> createState() => _LongVideoThumbnailState();
}

class _LongVideoThumbnailState extends State<_LongVideoThumbnail> {
  late Future<Uint8List?> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadThumbnail();
  }

  Future<Uint8List?> _loadThumbnail() async {
    if (widget.videoUrl.isEmpty) return null;

    if (_longVideoThumbnailCache.containsKey(widget.videoUrl)) {
      return _longVideoThumbnailCache[widget.videoUrl];
    }

    try {
      final bytes = await VideoThumbnail.thumbnailData(
        video: widget.videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 600, // wider for 16:9 cards
        quality: 75,
      );
      _longVideoThumbnailCache[widget.videoUrl] = bytes;
      return bytes;
    } catch (_) {
      _longVideoThumbnailCache[widget.videoUrl] = null;
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _future,
      builder: (context, snapshot) {
        // Generated thumbnail ready
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.cover,
            gaplessPlayback: true,
          );
        }

        // While generating (or on failure) — show cover/thumbnail URL
        if (widget.fallbackUrl.isNotEmpty) {
          return CachedNetworkImage(
            imageUrl: widget.fallbackUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => _Placeholder(isDarkMode: widget.isDarkMode),
            errorWidget: (_, __, ___) => _Placeholder(isDarkMode: widget.isDarkMode),
          );
        }

        return _Placeholder(isDarkMode: widget.isDarkMode);
      },
    );
  }
}

class _Placeholder extends StatelessWidget {
  final bool isDarkMode;
  const _Placeholder({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
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
}
