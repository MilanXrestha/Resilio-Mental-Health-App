import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../../video/domain/entities/video_entity.dart';
import '../../../video/presentation/bloc/short_video/short_video_bloc.dart';
import '../../../video/presentation/bloc/short_video/short_video_event.dart';
import '../../../video/presentation/bloc/short_video/short_video_state.dart';

/// Instagram-style vertical Reels screen with full-screen short video feed.
class ShortsScreen extends StatelessWidget {
  const ShortsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ShortVideoBloc>()..add(const LoadShortVideos()),
      child: const _ReelsView(),
    );
  }
}

class _ReelsView extends StatefulWidget {
  const _ReelsView();

  @override
  State<_ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<_ReelsView> {
  late PageController _pageController;
  int _currentIndex = 0;
  final Map<int, VideoPlayerController> _controllers = {};
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  // ── video lifecycle ──────────────────────────────────────────────────────

  Future<void> _initController(int index, String url) async {
    if (_controllers.containsKey(index)) return;
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _controllers[index] = controller;
    controller.addListener(() {
      if (mounted) setState(() {});
    });
    await controller.initialize();
    controller.setLooping(true);
    if (index == _currentIndex && mounted) {
      controller.play();
    }
  }

  void _onPageChanged(int index) {
    // Pause previous
    _controllers[_currentIndex]?.pause();
    setState(() {
      _currentIndex = index;
      _isPaused = false;
    });
    // Play current (or init if not yet loaded)
    final c = _controllers[index];
    if (c != null && c.value.isInitialized) {
      c.play();
    }
  }

  void _togglePlayPause() {
    final c = _controllers[_currentIndex];
    if (c == null) return;
    setState(() {
      if (c.value.isPlaying) {
        c.pause();
        _isPaused = true;
      } else {
        c.play();
        _isPaused = false;
      }
    });
  }

  // ── build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocConsumer<ShortVideoBloc, ShortVideoState>(
          listener: (context, state) {
            if (state is ShortVideoLoaded && state.videos.isNotEmpty) {
              // Pre-init first two
              _initController(0, state.videos[0].videoUrl);
              if (state.videos.length > 1) {
                _initController(1, state.videos[1].videoUrl);
              }
            }
          },
          builder: (context, state) {
            if (state is ShortVideoLoading || state is ShortVideoRefreshing) {
              return _buildLoading(context);
            }
            if (state is ShortVideoError) {
              return _buildError(context, state.message);
            }
            if (state is ShortVideoLoaded) {
              if (state.videos.isEmpty) return _buildEmpty(context);
              return _buildReelsFeed(context, state);
            }
            return _buildLoading(context);
          },
        ),
      ),
    );
  }

  // ── reels feed ───────────────────────────────────────────────────────────

  Widget _buildReelsFeed(BuildContext context, ShortVideoLoaded state) {
    final videos = state.videos;

    return Stack(
      children: [
        // Vertical page view
        PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: videos.length,
          onPageChanged: (i) {
            _onPageChanged(i);
            // Pre-init the next video
            if (i + 1 < videos.length) {
              _initController(i + 1, videos[i + 1].videoUrl);
            }
          },
          itemBuilder: (context, index) {
            final video = videos[index];
            // Eagerly init current
            _initController(index, video.videoUrl);
            return GestureDetector(
              onTap: _togglePlayPause,
              child: _ReelPage(
                video: video,
                controller: _controllers[index],
                isPaused: _isPaused && index == _currentIndex,
              ),
            );
          },
        ),

        // ── Top bar (Reels header) ────────────────────────────────────────
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
                    Text(
                      'Reels',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 26.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ── Right actions column ──────────────────────────────────────────
        if (videos.isNotEmpty)
          Positioned(
            right: 12.w,
            bottom: MediaQuery.of(context).padding.bottom + 100.h,
            child: _ActionColumn(video: videos[_currentIndex]),
          ),

        // ── Bottom info panel ─────────────────────────────────────────────
        if (videos.isNotEmpty)
          Positioned(
            left: 16.w,
            right: 80.w,
            bottom: MediaQuery.of(context).padding.bottom + 16.h,
            child: _InfoPanel(video: videos[_currentIndex]),
          ),

        // ── Progress indicator ─────────────────────────────────────────────
        if (videos.isNotEmpty && _controllers[_currentIndex] != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            child: _ProgressBar(controller: _controllers[_currentIndex]!),
          ),

        // ── Pause icon overlay ─────────────────────────────────────────────
        if (_isPaused)
          Center(
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                size: 56.sp,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
      ],
    );
  }

  // ── placeholders ─────────────────────────────────────────────────────────

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.w,
            child: CircularProgressIndicator(
              strokeWidth: 3.w,
              color: context.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading Reels...',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14.sp,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 48.sp, color: Colors.redAccent),
            SizedBox(height: 16.h),
            Text(
              'Could not load reels',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(fontSize: 13.sp, color: Colors.white60),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            FilledButton.icon(
              onPressed: () => context.read<ShortVideoBloc>().add(const LoadShortVideos()),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              style: FilledButton.styleFrom(
                backgroundColor: context.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.movie_filter_rounded, size: 64.sp, color: Colors.white24),
          SizedBox(height: 16.h),
          Text(
            'No Reels Yet',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Check back soon for new content',
            style: TextStyle(fontSize: 14.sp, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// REEL PAGE — single full-screen video
// ═══════════════════════════════════════════════════════════════════════════════

class _ReelPage extends StatelessWidget {
  final VideoEntity video;
  final VideoPlayerController? controller;
  final bool isPaused;

  const _ReelPage({
    required this.video,
    this.controller,
    required this.isPaused,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video or loading
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

        // Gradient overlays for text legibility
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
// ACTION COLUMN — right-side engagement buttons (Instagram-style)
// ═══════════════════════════════════════════════════════════════════════════════

class _ActionColumn extends StatelessWidget {
  final VideoEntity video;
  const _ActionColumn({required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Favorite
        FavoriteButton(
          contentId: video.id,
          contentType: FavoriteType.shortVideo,
          size: 30.sp,
          color: Colors.white,
        ),
        SizedBox(height: 4.h),
        Text('Like', style: _labelStyle),
        SizedBox(height: 20.h),

        // Comment
        _ActionIcon(
          icon: Icons.chat_bubble_outline_rounded,
          label: 'Comment',
          onTap: () {},
        ),
        SizedBox(height: 20.h),

        // Share
        _ActionIcon(
          icon: Icons.send_rounded,
          label: 'Share',
          onTap: () {},
        ),
        SizedBox(height: 20.h),

        // Music disc
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white38, width: 2.w),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: video.thumbnailUrl.isNotEmpty
                ? Image.network(video.thumbnailUrl, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _musicPlaceholder())
                : _musicPlaceholder(),
          ),
        ),
      ],
    );
  }

  Widget _musicPlaceholder() {
    return Container(
      color: Colors.grey.shade800,
      child: Icon(Icons.music_note_rounded, color: Colors.white54, size: 18.sp),
    );
  }

  static final _labelStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 28.sp),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// INFO PANEL — bottom-left creator info
// ═══════════════════════════════════════════════════════════════════════════════

class _InfoPanel extends StatelessWidget {
  final VideoEntity video;
  const _InfoPanel({required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Creator row
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

        // Caption
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

        // Mood tags
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

        // Music row
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
// PROGRESS BAR — thin progress indicator at the bottom
// ═══════════════════════════════════════════════════════════════════════════════

class _ProgressBar extends StatelessWidget {
  final VideoPlayerController controller;
  const _ProgressBar({required this.controller});

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