import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/video_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';

/// Beautiful TikTok/Instagram Reels style vertical video player
class ShortsPlayerScreen extends StatefulWidget {
  final List<VideoEntity> videos;
  final int initialIndex;

  const ShortsPlayerScreen({
    super.key,
    required this.videos,
    this.initialIndex = 0,
  });

  @override
  State<ShortsPlayerScreen> createState() => _ShortsPlayerScreenState();
}

class _ShortsPlayerScreenState extends State<ShortsPlayerScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  Map<int, VideoPlayerController> _controllers = {};
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _initializeVideo(widget.initialIndex);
  }

  Future<void> _initializeVideo(int index) async {
    if (index >= widget.videos.length) return;

    final video = widget.videos[index];
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(video.videoUrl),
    )..addListener(() {
      if (mounted) setState(() {});
    });

    await controller.initialize();
    controller.setLooping(true);

    if (mounted) {
      setState(() {
        _controllers[index] = controller;
      });
      controller.play();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    // Pause previous video
    if (_controllers.containsKey(_currentIndex)) {
      _controllers[_currentIndex]?.pause();
    }

    setState(() {
      _currentIndex = index;
    });

    // Initialize and play new video
    if (!_controllers.containsKey(index)) {
      _initializeVideo(index);
    } else {
      _controllers[index]?.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video Pages
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: widget.videos.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final video = widget.videos[index];
              return _VideoPage(
                video: video,
                controller: _controllers[index],
                isPlaying: _currentIndex == index && _isPlaying,
                onPlayPause: () {
                  if (_isPlaying) {
                    _controllers[index]?.pause();
                  } else {
                    _controllers[index]?.play();
                  }
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                },
              );
            },
          ),

          // Top Bar
          Positioned(
            top: 40.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Info Panel
          if (_currentIndex < widget.videos.length)
            Positioned(
              left: 16.w,
              right: 80.w,
              bottom: MediaQuery.of(context).padding.bottom + 16.h,
              child: _VideoInfo(video: widget.videos[_currentIndex]),
            ),

          // Right side action buttons
          if (_currentIndex < widget.videos.length)
            Positioned(
              right: 8.w,
              bottom: MediaQuery.of(context).padding.bottom + 80.h,
              child: _ActionButtons(video: widget.videos[_currentIndex]),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// VIDEO PAGE
// ─────────────────────────────────────────────────────────────────────────────

class _VideoPage extends StatelessWidget {
  final VideoEntity video;
  final VideoPlayerController? controller;
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const _VideoPage({
    required this.video,
    this.controller,
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlayPause,
      onDoubleTap: onPlayPause,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video
          if (controller != null && controller!.value.isInitialized)
            AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: VideoPlayer(controller!),
            )
          else
            Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(
                  color: context.primaryColor,
                ),
              ),
            ),

          // Play/Pause Indicator
          if (!isPlaying)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 80.sp,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),

          // Gradient overlay for better visibility
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// VIDEO INFO PANEL
// ─────────────────────────────────────────────────────────────────────────────

class _VideoInfo extends StatelessWidget {
  final VideoEntity video;

  const _VideoInfo({required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Artist name
        Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: context.primaryColor.withValues(alpha: 0.2),
              child: Text(
                video.artistName.isNotEmpty ? video.artistName[0].toUpperCase() : '?',
                style: TextStyle(
                  color: context.primaryColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@${video.artistName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    video.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // Mood tags
        if (video.moodTags.isNotEmpty)
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: video.moodTags.take(3).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: context.primaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '#$tag',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ACTION BUTTONS
// ─────────────────────────────────────────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  final VideoEntity video;

  const _ActionButtons({required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FavoriteButton(
          contentId: video.id,
          contentType: FavoriteType.shortVideo,
          size: 28.sp,
          color: Colors.white,
        ),
        SizedBox(height: 24.h),
        _ActionButton(
          icon: Icons.chat_bubble_outline_rounded,
          label: 'Comment',
          onTap: () {
            // TODO: Show comments
          },
        ),
        SizedBox(height: 24.h),
        _ActionButton(
          icon: Icons.share_rounded,
          label: 'Share',
          onTap: () {
            // TODO: Share video
          },
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
