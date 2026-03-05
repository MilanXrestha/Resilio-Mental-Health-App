import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/video_entity.dart';

/// Beautiful YouTube-style horizontal video player for therapy sessions
class LongVideoPlayerScreen extends StatefulWidget {
  final VideoEntity video;

  const LongVideoPlayerScreen({
    super.key,
    required this.video,
  });

  @override
  State<LongVideoPlayerScreen> createState() => _LongVideoPlayerScreenState();
}

class _LongVideoPlayerScreenState extends State<LongVideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isDescriptionExpanded = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.videoUrl),
    );

    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      showControlsOnInitialize: true,
      placeholder: Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(
            color: context.primaryColor,
          ),
        ),
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            'Error loading video',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120.h,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            title: Text(
              widget.video.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert_rounded, color: Colors.white),
                onPressed: () {
                  // TODO: Show options menu
                },
              ),
            ],
          ),

          // Video Player
          if (_isLoading)
            SliverToBoxAdapter(
              child: Container(
                height: 250.h,
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(
                    color: context.primaryColor,
                  ),
                ),
              ),
            )
          else if (_chewieController != null)
            SliverToBoxAdapter(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Chewie(controller: _chewieController!),
              ),
            ),

          // Video Info Section
          SliverPadding(
            padding: EdgeInsets.all(16.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Title
                Text(
                  widget.video.title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),

                SizedBox(height: 8.h),

                // Artist and stats row
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: context.primaryColor.withValues(alpha: 0.2),
                      child: Text(
                        widget.video.artistName.isNotEmpty 
                          ? widget.video.artistName[0].toUpperCase() 
                          : '?',
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
                            widget.video.artistName,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: context.textPrimaryColor,
                            ),
                          ),
                          Text(
                            '${widget.video.playCount} views • ${_formatDate(widget.video.createdAt)}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.sp,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Action buttons
                    IconButton(
                      icon: Icon(Icons.thumb_up_outlined),
                      onPressed: () {
                        // TODO: Like video
                      },
                      tooltip: 'Like',
                    ),
                    IconButton(
                      icon: Icon(Icons.share_rounded),
                      onPressed: () {
                        // TODO: Share video
                      },
                      tooltip: 'Share',
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Description
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDescriptionExpanded = !_isDescriptionExpanded;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.video.description,
                        maxLines: _isDescriptionExpanded ? null : 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.sp,
                          color: context.textSecondaryColor,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        _isDescriptionExpanded ? 'Show less' : 'Show more',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: context.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Mood tags section
                if (widget.video.moodTags.isNotEmpty) ...[
                  Text(
                    'Mood Tags',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: widget.video.moodTags.map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: context.primaryColor.withValues(alpha: 0.3),
                            width: 1.w,
                          ),
                        ),
                        child: Text(
                          '#$tag',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: context.primaryColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],

                SizedBox(height: 24.h),

                // Related videos section header
                Text(
                  'Related Sessions',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: context.textPrimaryColor,
                  ),
                ),
              ]),
            ),
          ),

          // Related Videos List (placeholder)
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _RelatedVideoCard(video: widget.video);
                },
                childCount: 3, // Placeholder count
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RELATED VIDEO CARD
// ─────────────────────────────────────────────────────────────────────────────

class _RelatedVideoCard extends StatelessWidget {
  final VideoEntity video;

  const _RelatedVideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 160.w,
              height: 90.h,
              color: context.primaryColor.withValues(alpha: 0.1),
              child: Icon(
                Icons.play_circle_outline_rounded,
                size: 40.sp,
                color: context.primaryColor,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Related Therapy Session ${DateTime.now().millisecond}',
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
                Text(
                  video.artistName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    color: context.textSecondaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${video.playCount} views',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    color: context.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          // More button
          IconButton(
            icon: Icon(Icons.more_vert_rounded, size: 24.sp),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
