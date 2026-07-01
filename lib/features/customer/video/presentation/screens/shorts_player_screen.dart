import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/services/video_cache_manager.dart';
import '../../domain/entities/video_entity.dart';
import '../widgets/shorts_reels_widgets.dart';

/// TikTok / Reels-style vertical player (same chrome as the main Reels tab).
///
/// Caching: each reel is streamed from a bounded on-disk cache
/// ([VideoCacheManager]) so replays and offline playback hit local files.
/// Memory: only a small window of controllers (current ±1) is kept alive —
/// everything else is disposed — to avoid OOM on long reel lists.
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
  final VideoCacheManager _cacheManager = VideoCacheManager();
  bool _isPlaying = true;
  bool _immersive = false;

  // Number of controllers kept alive on each side of the current index.
  static const int _window = 1;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _initializeVideo(_currentIndex);
    _initializeVideo(_currentIndex + 1);
    _prefetchAround(_currentIndex);
  }

  /// Builds a controller backed by the disk cache. Falls back to direct
  /// network streaming if the file can't be fetched (e.g. offline & uncached).
  Future<void> _initializeVideo(int index) async {
    if (index < 0 || index >= widget.videos.length) return;
    if (_controllers.containsKey(index)) return;

    // Reserve the slot immediately so concurrent calls don't double-init.
    final url = widget.videos[index].videoUrl;

    VideoPlayerController controller;
    try {
      final file = await _cacheManager.getSingleFile(url);
      controller = VideoPlayerController.file(file);
    } catch (_) {
      controller = VideoPlayerController.networkUrl(Uri.parse(url));
    }

    // Aborted while awaiting (page changed far away / screen disposed).
    if (!mounted || (index - _currentIndex).abs() > _window) {
      controller.dispose();
      return;
    }

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await controller.initialize();
    } catch (_) {
      controller.dispose();
      return;
    }
    controller.setLooping(true);

    if (!mounted || (index - _currentIndex).abs() > _window) {
      controller.dispose();
      return;
    }

    setState(() => _controllers[index] = controller);
    if (index == _currentIndex && _isPlaying) controller.play();
  }

  /// Warms the disk cache a couple reels ahead without holding controllers
  /// (disk only — keeps memory flat, smooths swiping, aids offline).
  void _prefetchAround(int index) {
    for (final i in [index + 2, index + 3]) {
      if (i >= 0 && i < widget.videos.length) {
        _cacheManager.getSingleFile(widget.videos[i].videoUrl).ignore();
      }
    }
  }

  /// Disposes controllers outside the current ±[_window] to cap memory.
  void _pruneControllers() {
    final toRemove = _controllers.keys
        .where((k) => (k - _currentIndex).abs() > _window)
        .toList();
    for (final k in toRemove) {
      _controllers[k]?.dispose();
      _controllers.remove(k);
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
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
      _isPlaying = true;
    });

    _pruneControllers();

    if (_controllers.containsKey(index)) {
      _controllers[index]?.play();
    } else {
      _initializeVideo(index);
    }

    // Preload neighbors + warm the cache ahead.
    _initializeVideo(index + 1);
    _initializeVideo(index - 1);
    _prefetchAround(index);
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

  void _toggleImmersive() {
    setState(() => _immersive = !_immersive);
    SystemChrome.setEnabledSystemUIMode(
      _immersive ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
    );
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

          // Top bar — hidden in immersive mode.
          if (!_immersive)
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(
                      children: [
                        _circleIconButton(
                          icon: Icons.close_rounded,
                          onTap: () => context.pop(),
                        ),
                        const Spacer(),
                        // Enter fullscreen / immersive.
                        _circleIconButton(
                          icon: Icons.fullscreen_rounded,
                          onTap: _toggleImmersive,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Chrome — hidden in immersive mode.
          if (!_immersive && current != null)
            Positioned(
              right: 12.w,
              bottom: bottomPad + 165.h,
              child: ShortsReelsActionColumn(video: current),
            ),

          if (!_immersive && current != null)
            Positioned(
              left: 16.w,
              right: 80.w,
              bottom: bottomPad + 85.h,
              child: ShortsReelsInfoPanel(video: current),
            ),

          if (!_immersive && current != null && activeController != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomPad + 55.h,
              child: ShortsReelsProgressBar(controller: activeController),
            ),

          // "Show UI" affordance — only control visible in immersive mode.
          if (_immersive)
            Positioned(
              top: 0,
              right: 12.w,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: _circleIconButton(
                    icon: Icons.fullscreen_exit_rounded,
                    onTap: _toggleImmersive,
                  ),
                ),
              ),
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

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24.sp),
      ),
    );
  }
}
