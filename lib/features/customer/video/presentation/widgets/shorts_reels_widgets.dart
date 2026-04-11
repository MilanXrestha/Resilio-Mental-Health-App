import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/video_entity.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import 'comment_sheet_widget.dart';

/// Shared vertical spacing between right-side Reels actions (like, comment, share, disc).
double shortsReelsActionGap(BuildContext context) => 32.h;

// ═══════════════════════════════════════════════════════════════════════════════
// Full-bleed video + gradient (used by tab Reels and routed Shorts player)
// ═══════════════════════════════════════════════════════════════════════════════

class ShortsReelVideoSurface extends StatelessWidget {
  final VideoPlayerController? controller;

  const ShortsReelVideoSurface({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (controller != null && controller!.value.isInitialized)
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller!.value.size.width,
              height: controller!.value.size.height,
              child: VideoPlayer(controller!),
            ),
          )
        else
          Container(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white.withValues(alpha: 0.5),
                strokeWidth: 2.w,
              ),
            ),
          ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
                stops: const [0.0, 0.2, 0.6, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Right column — same on Shorts tab and ShortsPlayerScreen route
// ═══════════════════════════════════════════════════════════════════════════════

class ShortsReelsActionColumn extends StatelessWidget {
  final VideoEntity video;

  const ShortsReelsActionColumn({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final gap = shortsReelsActionGap(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FavoriteButton(
          contentId: video.id,
          contentType: FavoriteType.shortVideo,
          size: 28.sp,
          color: Colors.white,
        ),
        SizedBox(height: gap),
        ShortsReelsActionIcon(
          icon: HugeIcons.strokeRoundedComment01,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => CommentSheetWidget(videoId: video.id),
            );
          },
        ),
        SizedBox(height: gap),
        ShortsReelsActionIcon(
          icon: HugeIcons.strokeRoundedSent,
          onTap: () {
            SharePlus.instance.share(
              ShareParams(
                text:
                    'Check out this video on Resilio: ${video.title}\n${video.videoUrl}',
              ),
            );
          },
        ),
        SizedBox(height: gap + 4.h),
        ShortsReelsMusicDisc(video: video),
      ],
    );
  }
}

class ShortsReelsActionIcon extends StatelessWidget {
  final dynamic icon;
  final VoidCallback onTap;

  const ShortsReelsActionIcon({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: HugeIcon(
        icon: icon,
        color: Colors.white,
        size: 28.sp,
      ),
    );
  }
}

class ShortsReelsMusicDisc extends StatefulWidget {
  final VideoEntity video;

  const ShortsReelsMusicDisc({super.key, required this.video});

  @override
  State<ShortsReelsMusicDisc> createState() => _ShortsReelsMusicDiscState();
}

class _ShortsReelsMusicDiscState extends State<ShortsReelsMusicDisc>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Container(
        width: 36.w,
        height: 36.w,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF2E2E2E), Color(0xFF121212)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white24, width: 2.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: widget.video.thumbnailUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: widget.video.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => _placeholder(),
                )
              : _placeholder(),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Icon(Icons.music_note_rounded, color: Colors.white70, size: 16.sp);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Bottom-left info
// ═══════════════════════════════════════════════════════════════════════════════

class ShortsReelsInfoPanel extends StatelessWidget {
  final VideoEntity video;

  const ShortsReelsInfoPanel({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundColor: context.primaryColor.withValues(alpha: 0.3),
              child: Text(
                video.artistName.isNotEmpty
                    ? video.artistName[0].toUpperCase()
                    : '?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                video.artistName,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.w),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                'Follow',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          video.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.sp,
            color: Colors.white,
            height: 1.4,
          ),
        ),
        if (video.moodTags.isNotEmpty) ...[
          SizedBox(height: 8.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: video.moodTags.take(3).map((tag) {
                return Padding(
                  padding: EdgeInsets.only(right: 6.w),
                  child: Text(
                    '#$tag',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.music_note_rounded, color: Colors.white70, size: 14.sp),
            SizedBox(width: 6.w),
            Flexible(
              child: Text(
                'Original audio — ${video.artistName}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  color: Colors.white70,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Thin scrubber
// ═══════════════════════════════════════════════════════════════════════════════

class ShortsReelsProgressBar extends StatelessWidget {
  final VideoPlayerController controller;

  const ShortsReelsProgressBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) return const SizedBox.shrink();

    return VideoProgressIndicator(
      controller,
      allowScrubbing: true,
      padding: EdgeInsets.zero,
      colors: VideoProgressColors(
        playedColor: Colors.white,
        bufferedColor: Colors.white.withValues(alpha: 0.3),
        backgroundColor: Colors.white.withValues(alpha: 0.1),
      ),
    );
  }
}
