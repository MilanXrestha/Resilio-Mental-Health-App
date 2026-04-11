import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../domain/entities/video_entity.dart';
import '../widgets/shorts_reels_widgets.dart';

/// TikTok / Reels-style vertical player (same chrome as the main Reels tab).
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
  late int _currentIndex;
  final Map<int, VideoPlayerController> _controllers = {};
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
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
    for (final c in _controllers.values) {
      c.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    _controllers[_currentIndex]?.pause();

    setState(() {
      _currentIndex = index;
    });

    if (!_controllers.containsKey(index)) {
      _initializeVideo(index);
    } else {
      _controllers[index]?.play();
      setState(() => _isPlaying = true);
    }
  }

  void _togglePlayPause() {
    final c = _controllers[_currentIndex];
    if (c == null) return;
    setState(() {
      if (c.value.isPlaying) {
        c.pause();
        _isPlaying = false;
      } else {
        c.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final current = _currentIndex < widget.videos.length
        ? widget.videos[_currentIndex]
        : null;
    final activeController = _controllers[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: widget.videos.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: _togglePlayPause,
                child: ShortsReelVideoSurface(controller: _controllers[index]),
              );
            },
          ),

          // Top bar — same gradient treatment as Reels tab; close instead of title
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
              ),
            ),
          ),

          if (current != null)
            Positioned(
              right: 12.w,
              bottom: bottomPad + 165.h,
              child: ShortsReelsActionColumn(video: current),
            ),

          if (current != null)
            Positioned(
              left: 16.w,
              right: 80.w,
              bottom: bottomPad + 85.h,
              child: ShortsReelsInfoPanel(video: current),
            ),

          if (current != null && activeController != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomPad + 55.h,
              child: ShortsReelsProgressBar(controller: activeController),
            ),

          if (!_isPlaying)
            IgnorePointer(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 80.w,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
