import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../dashboard/presentation/widgets/long_video_card_widget.dart';
import '../../domain/entities/video_entity.dart';
import '../bloc/long_video/long_video_bloc.dart';
import '../bloc/long_video/long_video_event.dart';
import '../bloc/long_video/long_video_state.dart';
import '../widgets/comment_sheet_widget.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';

/// Beautiful YouTube-style horizontal video player for therapy sessions
class LongVideoPlayerScreen extends StatefulWidget {
  final VideoEntity video;

  const LongVideoPlayerScreen({super.key, required this.video});

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
      // Hides the ⋮ menu (playback speed on Material / desktop). iOS Cupertino
      // still exposes speed via its dedicated control when applicable.
      showOptions: false,
      placeholder: Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(color: context.primaryColor),
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
          ),

          if (_isLoading)
            SliverToBoxAdapter(
              child: Container(
                height: 250.h,
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(color: context.primaryColor),
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
                      backgroundColor: context.primaryColor.withValues(
                        alpha: 0.2,
                      ),
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
                            _formatDate(widget.video.createdAt),
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
                    FavoriteButton(
                      contentId: widget.video.id,
                      contentType: FavoriteType.longVideo,
                      size: 24.sp,
                      color: context.textPrimaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
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

                // Comment preview box
                _CommentPreviewBox(video: widget.video),

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

          // Related Videos List
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            sliver: SliverToBoxAdapter(
              child: BlocProvider(
                create: (_) => getIt<LongVideoBloc>()
                  ..add(
                    LoadLongVideos(
                      categoryId: widget.video.categoryId,
                      limit: 5,
                    ),
                  ),
                child: BlocBuilder<LongVideoBloc, LongVideoState>(
                  builder: (context, state) {
                    if (state is LongVideoLoading) {
                      return Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: context.primaryColor,
                          ),
                        ),
                      );
                    }
                    if (state is LongVideoLoaded) {
                      final related = state.videos
                          .where((v) => v.id != widget.video.id)
                          .toList();
                      if (related.isEmpty) return const SizedBox.shrink();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: related.length,
                        itemBuilder: (context, index) {
                          return _RelatedVideoCard(video: related[index]);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
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
    return InkWell(
      onTap: () {
        context.pushReplacementNamed(RouteNames.longVideoPlayer, extra: video);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: SizedBox(
                width: 160.w,
                height: 90.h,
                child: _relatedThumbnail(context, video),
              ),
            ),
            SizedBox(width: 12.w),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _relatedThumbnail(BuildContext context, VideoEntity video) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fallbackUrl = video.thumbnailUrl.isNotEmpty
        ? video.thumbnailUrl
        : video.coverImageUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        // Generate a poster from the video URL (same builder as the cards),
        // falling back to thumbnail/cover URL when generation fails.
        LongVideoThumbnail(
          videoUrl: video.videoUrl,
          fallbackUrl: fallbackUrl,
          isDarkMode: isDarkMode,
        ),
        Center(
          child: Icon(
            Icons.play_circle_outline_rounded,
            size: 40.sp,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMMENT PREVIEW BOX
// ─────────────────────────────────────────────────────────────────────────────

class _CommentPreviewBox extends StatelessWidget {
  final VideoEntity video;

  const _CommentPreviewBox({required this.video});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => CommentSheetWidget(videoId: video.id),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.primaryColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Comments',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.unfold_more_rounded,
                  color: context.textSecondaryColor,
                  size: 20.sp,
                ),
              ],
            ),
            if (video.commentCount > 0) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  CircleAvatar(
                    radius: 12.r,
                    backgroundColor: context.primaryColor.withValues(alpha: 0.2),
                    child: Icon(
                      Icons.person,
                      size: 16.sp,
                      color: context.primaryColor,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Tap to view comments...',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.sp,
                        color: context.textPrimaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
