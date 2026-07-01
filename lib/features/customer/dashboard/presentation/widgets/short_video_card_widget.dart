import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routing/route_names.dart';
import '../../../../../core/services/media_duration_cache.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/media_duration_resolver.dart';
import '../../../../../core/widgets/premium_tag_widget.dart';
import '../../../video/domain/entities/video_entity.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../../subscription/presentation/bloc/subscription_bloc.dart';
import '../../../subscription/presentation/bloc/subscription_state.dart';

// Process-level in-memory cache: videoUrl → thumbnail bytes (or null = failed).
final Map<String, Uint8List?> _thumbnailCache = {};

/// Beautiful short video card widget (9:16 aspect ratio - TikTok/Reels style).
/// Thumbnail is generated from the video URL via the `video_thumbnail` package,
/// with a per-session in-memory cache. Falls back to `thumbnailUrl` if the video
/// URL is missing, and to a placeholder icon if both fail.
class ShortVideoCardWidget extends StatelessWidget {
  final VideoEntity video;
  final VoidCallback? onTap;
  final double? width;
  final double? containerWidth;
  final EdgeInsetsGeometry? margin;

  const ShortVideoCardWidget({
    super.key,
    required this.video,
    this.onTap,
    this.width,
    this.containerWidth,
    this.margin,
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
        width: width ?? 150.w,
        margin: margin ?? EdgeInsets.only(right: 10.w),
        child: Column(
          crossAxisAlignment: width != null ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
          children: [
            Stack(
              fit: width != null ? StackFit.loose : StackFit.loose,
              children: [
                Container(
                  height: 200.h,
                  width: containerWidth ?? 145.w,
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
                    child: _VideoThumbnail(
                      videoUrl: video.videoUrl,
                      fallbackUrl: video.thumbnailUrl,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                ),

                // REELS badge
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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

                // Premium Tag
                PremiumTagWidget(
                  isPremium: video.isPremium,
                  top: 8,
                  left: 8,
                ),

                // Play overlay
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

                // Duration chip — uses DB value, else probes the video.
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: MediaDurationResolver(
                    url: video.videoUrl,
                    fallbackSeconds: video.durationSeconds,
                    kind: MediaKind.video,
                    builder: (context, label) {
                      if (label == null) return const SizedBox.shrink();
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // View count chip
                Positioned(
                  bottom: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.visibility, size: 10.sp, color: Colors.white),
                        SizedBox(width: 2.w),
                        Text(
                          _formatViewCount(video.playCount),
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

            SizedBox(height: 6.h),
            Text(
              video.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            if (video.artistName.isNotEmpty) ...[
              SizedBox(height: 2.h),
              Text(
                video.artistName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10.sp,
                  color: isDarkMode ? Colors.white54 : Colors.black45,
                ),
              ),
            ],
            SizedBox(height: 4.h),
          ],
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

class _VideoThumbnail extends StatefulWidget {
  final String videoUrl;
  final String fallbackUrl;
  final bool isDarkMode;

  const _VideoThumbnail({
    required this.videoUrl,
    required this.fallbackUrl,
    required this.isDarkMode,
  });

  @override
  State<_VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<_VideoThumbnail> {
  late Future<Uint8List?> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadThumbnail();
  }

  Future<Uint8List?> _loadThumbnail() async {
    if (widget.videoUrl.isEmpty) return null;

    // Return cached result immediately (including null = failed).
    if (_thumbnailCache.containsKey(widget.videoUrl)) {
      return _thumbnailCache[widget.videoUrl];
    }

    try {
      final bytes = await VideoThumbnail.thumbnailData(
        video: widget.videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 300,   // ~2× card width for sharpness on high-DPI screens
        quality: 75,
      );
      _thumbnailCache[widget.videoUrl] = bytes;
      return bytes;
    } catch (_) {
      _thumbnailCache[widget.videoUrl] = null;
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _future,
      builder: (context, snapshot) {
        // Generated thumbnail available
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.cover,
            gaplessPlayback: true,
          );
        }

        // Still generating — show fallback URL (or placeholder) while waiting
        if (widget.fallbackUrl.isNotEmpty) {
          return CachedNetworkImage(
            imageUrl: widget.fallbackUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => _Placeholder(isDarkMode: widget.isDarkMode),
            errorWidget: (context, url, error) => _Placeholder(isDarkMode: widget.isDarkMode),
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
          size: 30.sp,
          color: context.textSecondaryColor,
        ),
      ),
    );
  }
}
