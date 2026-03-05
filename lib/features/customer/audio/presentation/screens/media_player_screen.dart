import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/audio_entity.dart';

/// Beautiful media player screen for audio playback
class MediaPlayerScreen extends StatefulWidget {
  final AudioEntity audioTrack;

  const MediaPlayerScreen({
    super.key,
    required this.audioTrack,
  });

  @override
  State<MediaPlayerScreen> createState() => _MediaPlayerScreenState();
}

class _MediaPlayerScreenState extends State<MediaPlayerScreen> {
  late final AudioPlayer _audioPlayer;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
    _setupListeners();
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setUrl(widget.audioTrack.audioUrl);
      setState(() {
        _duration = Duration(seconds: widget.audioTrack.durationSeconds);
      });
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  void _setupListeners() {
    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
    });

    _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
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
                    IconButton(
                      icon: Icon(
                        Icons.more_horiz_rounded,
                        size: 28.sp,
                        color: context.textPrimaryColor,
                      ),
                      onPressed: () {
                        // TODO: Show options menu
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Album art
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 30.r,
                          offset: Offset(0, 15.h),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: widget.audioTrack.coverImageUrl.isNotEmpty
                          ? Image.network(
                              widget.audioTrack.coverImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildAlbumPlaceholder(),
                            )
                          : _buildAlbumPlaceholder(),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Track info
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    // Title
                    Text(
                      widget.audioTrack.title,
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
                    // Artist
                    Text(
                      widget.audioTrack.artistName,
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
                        inactiveTrackColor: context.primaryColor.withValues(alpha: 0.3),
                        thumbColor: context.primaryColor,
                      ),
                      child: Slider(
                        value: _position.inSeconds.toDouble(),
                        min: 0,
                        max: _duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          _audioPlayer.seek(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // Time labels
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
                    // Skip back 10s
                    IconButton(
                      icon: Icon(
                        Icons.replay_10_rounded,
                        size: 36.sp,
                        color: context.textPrimaryColor,
                      ),
                      onPressed: () {
                        final newPosition = _position - const Duration(seconds: 10);
                        _audioPlayer.seek(
                          newPosition < Duration.zero ? Duration.zero : newPosition,
                        );
                      },
                    ),

                    // Previous track
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        size: 44.sp,
                        color: context.textPrimaryColor,
                      ),
                      onPressed: () {
                        // TODO: Play previous track
                      },
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
                          _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
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
                        color: context.textPrimaryColor,
                      ),
                      onPressed: () {
                        // TODO: Play next track
                      },
                    ),

                    // Skip forward 10s
                    IconButton(
                      icon: Icon(
                        Icons.forward_10_rounded,
                        size: 36.sp,
                        color: context.textPrimaryColor,
                      ),
                      onPressed: () {
                        final newPosition = _position + const Duration(seconds: 10);
                        _audioPlayer.seek(
                          newPosition > _duration ? _duration : newPosition,
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 48.h),
            ],
          ),
        ),
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
