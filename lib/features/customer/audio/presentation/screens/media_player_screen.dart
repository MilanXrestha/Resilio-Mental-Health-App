import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/audio_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';

/// Arguments for [MediaPlayerScreen] — a playlist plus the track to start on.
class MediaPlayerArgs {
  final List<AudioEntity> playlist;
  final int initialIndex;

  const MediaPlayerArgs({
    required this.playlist,
    this.initialIndex = 0,
  });

  /// Convenience for a single-track playlist.
  factory MediaPlayerArgs.single(AudioEntity track) =>
      MediaPlayerArgs(playlist: [track], initialIndex: 0);
}

/// Beautiful media player screen with a rotating round album cover,
/// swipe-to-change-track, and an "Up Next" queue.
class MediaPlayerScreen extends StatefulWidget {
  final List<AudioEntity> playlist;
  final int initialIndex;

  const MediaPlayerScreen({
    super.key,
    required this.playlist,
    this.initialIndex = 0,
  });

  @override
  State<MediaPlayerScreen> createState() => _MediaPlayerScreenState();
}

class _MediaPlayerScreenState extends State<MediaPlayerScreen>
    with SingleTickerProviderStateMixin {
  late final AudioPlayer _audioPlayer;
  late final PageController _pageController;
  late final AnimationController _rotationController;

  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isPlaying = false;
  int _currentIndex = 0;

  // Guards against the PageView<->player index feedback loop.
  bool _isProgrammaticPageChange = false;

  AudioEntity get _current => widget.playlist[_currentIndex];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.playlist.length - 1);
    _audioPlayer = AudioPlayer();
    _pageController = PageController(initialPage: _currentIndex);
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _initAudio();
    _setupListeners();
  }

  Future<void> _initAudio() async {
    try {
      final initialDuration = await _audioPlayer.setAudioSources(
        widget.playlist
            .map((t) => AudioSource.uri(Uri.parse(t.audioUrl)))
            .toList(),
        initialIndex: _currentIndex,
        initialPosition: Duration.zero,
      );
      // Real media duration (setAudioSources returns the initial track's length);
      // durationStream keeps it in sync. The DB value is often blank → 00:00.
      if (mounted) {
        setState(() => _duration = initialDuration ?? Duration.zero);
      }
      _audioPlayer.play();
    } catch (e) {
      debugPrint('Error loading audio: $e');
    }
  }

  void _setupListeners() {
    _audioPlayer.playerStateStream.listen((state) {
      if (!mounted) return;
      setState(() => _isPlaying = state.playing);
      if (state.playing) {
        if (!_rotationController.isAnimating) _rotationController.repeat();
      } else {
        _rotationController.stop();
      }
    });

    _audioPlayer.positionStream.listen((position) {
      if (mounted) setState(() => _position = position);
    });

    _audioPlayer.durationStream.listen((duration) {
      if (mounted && duration != null) setState(() => _duration = duration);
    });

    // Track changes driven by the player (next/prev buttons, auto-advance).
    _audioPlayer.currentIndexStream.listen((index) {
      if (!mounted || index == null || index == _currentIndex) return;
      setState(() {
        _currentIndex = index;
        // Use the player's real duration for the new track; durationStream will
        // refine it. Don't fall back to the DB value (often 0/blank) — that
        // would show 00:00 as the end time.
        _duration = _audioPlayer.duration ?? Duration.zero;
      });
      if (_pageController.hasClients &&
          _pageController.page?.round() != index) {
        _isProgrammaticPageChange = true;
        _pageController
            .animateToPage(
          index,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        )
            .then((_) => _isProgrammaticPageChange = false);
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pageController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Triggered by user swiping the album art.
  void _onPageChanged(int index) {
    if (_isProgrammaticPageChange || index == _currentIndex) return;
    _audioPlayer.seek(Duration.zero, index: index);
    _audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.primaryColor.withValues(alpha: 0.8),
              context.backgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 32.sp,
                        color: context.textPrimaryColor,
                      ),
                      onPressed: () => context.pop(),
                    ),
                    Text(
                      'Now Playing',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    FavoriteButton(
                      contentId: _current.id,
                      contentType: FavoriteType.audio,
                      size: 28.sp,
                      color: context.textPrimaryColor,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Swipeable rotating round album art
              SizedBox(
                height: 300.r,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: widget.playlist.length,
                  itemBuilder: (context, index) {
                    return Center(child: _buildAlbumArt(widget.playlist[index]));
                  },
                ),
              ),

              const Spacer(),

              // Track info
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Text(
                      _current.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      _current.artistName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Progress bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 4.h,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 6.r,
                        ),
                        overlayShape: SliderComponentShape.noOverlay,
                        activeTrackColor: context.primaryColor,
                        inactiveTrackColor:
                            context.primaryColor.withValues(alpha: 0.3),
                        thumbColor: context.primaryColor,
                      ),
                      child: Slider(
                        value: _position.inSeconds
                            .toDouble()
                            .clamp(0, _duration.inSeconds.toDouble()),
                        min: 0,
                        max: _duration.inSeconds.toDouble() > 0
                            ? _duration.inSeconds.toDouble()
                            : 1,
                        onChanged: (value) {
                          _audioPlayer.seek(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_position),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: context.textSecondaryColor,
                            ),
                          ),
                          Text(
                            _formatDuration(_duration),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Playback controls
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.replay_10_rounded,
                        size: 36.sp,
                        color: context.textPrimaryColor,
                      ),
                      onPressed: () {
                        final newPosition =
                            _position - const Duration(seconds: 10);
                        _audioPlayer.seek(
                          newPosition < Duration.zero
                              ? Duration.zero
                              : newPosition,
                        );
                      },
                    ),

                    // Previous track
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        size: 44.sp,
                        color: _audioPlayer.hasPrevious
                            ? context.textPrimaryColor
                            : context.textPrimaryColor.withValues(alpha: 0.3),
                      ),
                      onPressed: _audioPlayer.hasPrevious
                          ? () => _audioPlayer.seekToPrevious()
                          : null,
                    ),

                    // Play/Pause
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.primaryColor,
                            context.primaryColor.withValues(alpha: 0.8),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: context.primaryColor.withValues(alpha: 0.4),
                            blurRadius: 20.r,
                            offset: Offset(0, 8.h),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          _isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 48.sp,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (_isPlaying) {
                            _audioPlayer.pause();
                          } else {
                            _audioPlayer.play();
                          }
                        },
                      ),
                    ),

                    // Next track
                    IconButton(
                      icon: Icon(
                        Icons.skip_next_rounded,
                        size: 44.sp,
                        color: _audioPlayer.hasNext
                            ? context.textPrimaryColor
                            : context.textPrimaryColor.withValues(alpha: 0.3),
                      ),
                      onPressed: _audioPlayer.hasNext
                          ? () => _audioPlayer.seekToNext()
                          : null,
                    ),

                    IconButton(
                      icon: Icon(
                        Icons.forward_10_rounded,
                        size: 36.sp,
                        color: context.textPrimaryColor,
                      ),
                      onPressed: () {
                        final newPosition =
                            _position + const Duration(seconds: 10);
                        _audioPlayer.seek(
                          newPosition > _duration ? _duration : newPosition,
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Up Next button (only when there is a real playlist)
              if (widget.playlist.length > 1)
                TextButton.icon(
                  onPressed: _showUpNext,
                  icon: Icon(
                    Icons.queue_music_rounded,
                    size: 20.sp,
                    color: context.textSecondaryColor,
                  ),
                  label: Text(
                    'Up Next',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlbumArt(AudioEntity track) {
    final image = track.coverImageUrl.isNotEmpty
        ? Image.network(
            track.coverImageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => _buildAlbumPlaceholder(),
          )
        : _buildAlbumPlaceholder();

    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationController.value * 2 * math.pi,
          child: child,
        );
      },
      child: Container(
        width: 280.r,
        height: 280.r,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              image,
              // Center hole, like a vinyl record.
              Center(
                child: Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.backgroundColor,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.6),
                      width: 3.r,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 12.r,
                      height: 12.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUpNext() {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: context.textSecondaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Text(
                      'Up Next',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${widget.playlist.length} tracks',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.sp,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.playlist.length,
                  itemBuilder: (context, index) {
                    final track = widget.playlist[index];
                    final isCurrent = index == _currentIndex;
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: SizedBox(
                          width: 48.r,
                          height: 48.r,
                          child: track.coverImageUrl.isNotEmpty
                              ? Image.network(
                                  track.coverImageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) =>
                                      _buildMiniPlaceholder(),
                                )
                              : _buildMiniPlaceholder(),
                        ),
                      ),
                      title: Text(
                        track.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          fontWeight:
                              isCurrent ? FontWeight.w600 : FontWeight.w500,
                          color: isCurrent
                              ? context.primaryColor
                              : context.textPrimaryColor,
                        ),
                      ),
                      subtitle: Text(
                        track.artistName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          color: context.textSecondaryColor,
                        ),
                      ),
                      trailing: isCurrent
                          ? Icon(
                              Icons.equalizer_rounded,
                              size: 20.sp,
                              color: context.primaryColor,
                            )
                          : Text(
                              track.formattedDuration,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                color: context.textSecondaryColor,
                              ),
                            ),
                      onTap: () {
                        Navigator.pop(sheetContext);
                        _audioPlayer.seek(Duration.zero, index: index);
                        _audioPlayer.play();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMiniPlaceholder() {
    return Container(
      color: context.primaryColor.withValues(alpha: 0.3),
      child: Icon(
        Icons.music_note_rounded,
        size: 24.sp,
        color: Colors.white.withValues(alpha: 0.8),
      ),
    );
  }

  Widget _buildAlbumPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.primaryColor.withValues(alpha: 0.6),
            context.primaryColor.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Icon(
        Icons.music_note_rounded,
        size: 100.sp,
        color: Colors.white.withValues(alpha: 0.8),
      ),
    );
  }
}
