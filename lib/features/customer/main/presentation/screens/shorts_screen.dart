import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import 'package:Resilio/l10n/app_localizations.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/services/video_cache_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../video/domain/entities/video_entity.dart';
import '../../../video/presentation/bloc/short_video/short_video_bloc.dart';
import '../../../video/presentation/bloc/short_video/short_video_event.dart';
import '../../../video/presentation/bloc/short_video/short_video_state.dart';
import '../../../video/presentation/widgets/shorts_reels_widgets.dart';
import '../cubit/main_screen_cubit.dart' show MainScreenCubit, MainScreenState;

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

class _ReelsViewState extends State<_ReelsView> with WidgetsBindingObserver {
  late PageController _pageController;
  int _currentIndex = 0;
  final Map<int, VideoPlayerController> _controllers = {};
  final Set<int> _initializing = {};
  final VideoCacheManager _cacheManager = VideoCacheManager();
  List<VideoEntity> _videos = const [];
  bool _isPaused = true;
  bool _immersive = false;

  // Controllers kept alive on each side of the current index (OOM guard).
  static const int _window = 1;

  // Tracks whether this tab is the visible page in the outer PageView.
  // TickerMode is inherited and set to false by Flutter's PageView for
  // off-screen keepalive pages — we piggyback on that to pause/resume.
  bool _wasTickerEnabled = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TickerMode.valuesOf returns false when our page is off-screen inside
    // the outer PageView (KeepAlivePage uses TickerMode(enabled: false) for
    // non-active pages), letting us auto-pause/resume without extra state.
    final tickerEnabled = TickerMode.valuesOf(context).enabled;
    if (tickerEnabled == _wasTickerEnabled) return;
    _wasTickerEnabled = tickerEnabled;

    if (!tickerEnabled) {
      // Tab is no longer visible — pause the active video and drop immersive
      // so other tabs / the bottom nav aren't left in fullscreen.
      _controllers[_currentIndex]?.pause();
      if (_immersive) {
        _immersive = false;
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    }
    // Autoplay removed as requested - we no longer resume here
  }

  void _toggleImmersive() {
    setState(() => _immersive = !_immersive);
    SystemChrome.setEnabledSystemUIMode(
      _immersive ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      _controllers[_currentIndex]?.pause();
    }
    // Autoplay removed - no resume on app lifecycle change
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  // ── video lifecycle ──────────────────────────────────────────────────────

  // Cache-backed init: streams from the bounded disk cache (offline-capable),
  // falls back to network streaming on a fetch miss. Race-safe via
  // [_initializing] so itemBuilder + onPageChanged can't double-download.
  Future<void> _initController(int index, String url) async {
    if (_controllers.containsKey(index) || _initializing.contains(index)) return;
    _initializing.add(index);

    VideoPlayerController controller;
    try {
      final file = await _cacheManager.getSingleFile(url);
      controller = VideoPlayerController.file(file);
    } catch (_) {
      controller = VideoPlayerController.networkUrl(Uri.parse(url));
    }

    if (!mounted || (index - _currentIndex).abs() > _window) {
      controller.dispose();
      _initializing.remove(index);
      return;
    }

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await controller.initialize();
    } catch (_) {
      controller.dispose();
      _initializing.remove(index);
      return;
    }
    controller.setLooping(true);

    if (!mounted || (index - _currentIndex).abs() > _window) {
      controller.dispose();
      _initializing.remove(index);
      return;
    }

    setState(() => _controllers[index] = controller);
    _initializing.remove(index);

    // Resume behaviour: if this is the current reel and the user hasn't paused,
    // start it once it finishes loading (matches the old page-change autoplay).
    if (index == _currentIndex && !_isPaused) controller.play();
  }

  void _pruneControllers() {
    final toRemove = _controllers.keys
        .where((k) => (k - _currentIndex).abs() > _window)
        .toList();
    for (final k in toRemove) {
      _controllers[k]?.dispose();
      _controllers.remove(k);
    }
  }

  // Warm the disk cache a couple reels ahead (disk only — memory stays flat).
  void _prefetchAround(int index) {
    for (final i in [index + 2, index + 3]) {
      if (i >= 0 && i < _videos.length) {
        _cacheManager.getSingleFile(_videos[i].videoUrl).ignore();
      }
    }
  }

  void _onPageChanged(int index) {
    // Pause previous
    _controllers[_currentIndex]?.pause();

    setState(() {
      _currentIndex = index;
      _isPaused = false; // Next page gets auto-played
    });

    _pruneControllers();

    // Auto-play if ready; otherwise _initController plays it once loaded.
    _controllers[index]?.play();

    _prefetchAround(index);
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
      child: BlocListener<MainScreenCubit, MainScreenState>(
        listener: (context, mainState) {
          // If tab is not index 2 (Reels), pause video
          if (mainState.selectedIndex != 2) {
            _controllers[_currentIndex]?.pause();
          }
          // Autoplay removed - no resume on tab change
        },
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
      ),
    );
  }

  // ── reels feed ───────────────────────────────────────────────────────────

  Widget _buildReelsFeed(BuildContext context, ShortVideoLoaded state) {
    final videos = state.videos;
    _videos = videos;

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
              child: ShortsReelVideoSurface(controller: _controllers[index]),
            );
          },
        ),

        // ── Top bar (Reels header) — hidden in immersive mode ─────────────
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
                      Text(
                        AppLocalizations.of(context)!.homeReels,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
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

        // ── Right actions column ──────────────────────────────────────────
        if (!_immersive && videos.isNotEmpty)
          Positioned(
            right: 12.w,
            bottom: MediaQuery.of(context).padding.bottom + 165.h,
            child: ShortsReelsActionColumn(video: videos[_currentIndex]),
          ),

        // ── Bottom info panel ─────────────────────────────────────────────
        if (!_immersive && videos.isNotEmpty)
          Positioned(
            left: 16.w,
            right: 80.w,
            bottom: MediaQuery.of(context).padding.bottom + 85.h,
            child: ShortsReelsInfoPanel(video: videos[_currentIndex]),
          ),

        // ── Progress indicator ─────────────────────────────────────────────
        if (!_immersive && videos.isNotEmpty && _controllers[_currentIndex] != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom + 55.h,
            child: ShortsReelsProgressBar(
              controller: _controllers[_currentIndex]!,
            ),
          ),

        // ── "Show UI" affordance — only control visible in immersive mode ──
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

        // ── Pause icon overlay ─────────────────────────────────────────────
        if (_isPaused)
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
            AppLocalizations.of(context)!.homeLoadingReels,
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
              AppLocalizations.of(context)!.homeCouldNotLoadReels,
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
              label: Text(AppLocalizations.of(context)!.homeRetry),
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
            AppLocalizations.of(context)!.homeNoReelsYet,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppLocalizations.of(context)!.homeCheckBackSoon,
            style: TextStyle(fontSize: 14.sp, color: Colors.white54),
          ),
        ],
      ),
    );
  }
}