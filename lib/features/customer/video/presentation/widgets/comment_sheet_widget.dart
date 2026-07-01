import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/services/auth_token_service.dart';
import '../../domain/entities/video_comment_entity.dart';
import '../../domain/repositories/video_repository.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';

class CommentSheetWidget extends StatefulWidget {
  final String videoId;

  const CommentSheetWidget({super.key, required this.videoId});

  @override
  State<CommentSheetWidget> createState() => _CommentSheetWidgetState();
}

class _CommentSheetWidgetState extends State<CommentSheetWidget> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  List<VideoCommentEntity> _comments = [];
  bool _isLoading = true;
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    final result = await getIt<VideoRepository>().getVideoComments(
      widget.videoId,
    );
    result.fold(
      (failure) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load comments: ${failure.message}'),
            ),
          );
        }
      },
      (comments) {
        if (mounted) {
          setState(() {
            _comments = comments;
            _isLoading = false;
          });
        }
      },
    );
  }

  Future<void> _postComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    // The backend's video_comments.user_id references users(id) — the Supabase
    // UUID, not the Firebase uid. AuthTokenService.userId holds that synced id.
    final userId = getIt<AuthTokenService>().userId;
    if (user == null || userId == null || userId.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please login to comment')));
      return;
    }

    setState(() => _isPosting = true);

    final result = await getIt<VideoRepository>().addVideoComment(
      videoId: widget.videoId,
      userId: userId,
      content: content,
    );

    result.fold(
      (failure) {
        if (mounted) {
          setState(() => _isPosting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to post comment: ${failure.message}'),
            ),
          );
        }
      },
      (newComment) {
        if (mounted) {
          setState(() {
            _comments.insert(0, newComment);
            _commentController.clear();
            _isPosting = false;
          });
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  void _handleReply(String username) {
    if (_commentController.text.isEmpty) {
      _commentController.text = '@$username ';
    } else {
      _commentController.text = '${_commentController.text} @$username ';
    }
    _commentController.selection = TextSelection.fromPosition(
      TextPosition(offset: _commentController.text.length),
    );
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Column(
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white24 : Colors.black12,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Comments',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: isDark ? Colors.white12 : Colors.black12, height: 1),

          // Comments List
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFFFFD700)),
                  )
                : _comments.isEmpty
                ? _buildEmptyState(isDark, textColor)
                : ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16.w),
                    itemCount: _comments.length,
                    separatorBuilder: (_, __) => SizedBox(height: 20.h),
                    itemBuilder: (context, index) =>
                        _CommentItem(
                          comment: _comments[index],
                          isDark: isDark,
                          textColor: textColor,
                          onReply: () => _handleReply(_comments[index].displayName),
                        ),
                  ),
          ),

          // Input field
          _buildInputArea(isDark, textColor),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark, Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HugeIcon(
          icon: HugeIcons.strokeRoundedComment01,
          color: isDark ? Colors.white24 : Colors.black26,
          size: 64.sp,
        ),
        SizedBox(height: 16.h),
        Text(
          'No comments yet',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14.sp,
            color: textColor.withValues(alpha: 0.6),
          ),
        ),
        Text(
          'Be the first to share your thoughts!',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
            color: textColor.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }

  Widget _buildInputArea(bool isDark, Color textColor) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        String? avatarUrl;
        if (profileState is ProfileLoaded) {
          avatarUrl = profileState.profile.photoUrl;
        } else if (profileState is ProfileUpdating) {
          avatarUrl = profileState.currentProfile.photoUrl;
        } else if (profileState is ProfileUpdateSuccess) {
          avatarUrl = profileState.profile.photoUrl;
        }

        avatarUrl ??= FirebaseAuth.instance.currentUser?.photoURL;

        return Container(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 16.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            // Border removed as requested
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: isDark ? Colors.white12 : Colors.grey[200],
                backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                    ? NetworkImage(avatarUrl)
                    : null,
                child: (avatarUrl == null || avatarUrl.isEmpty)
                    ? Icon(Icons.person, size: 22.sp, color: isDark ? Colors.white54 : Colors.black54)
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 13.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _commentController,
                    autofocus: false,
                    cursorColor: textColor,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: textColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: textColor.withValues(alpha: 0.4),
                        fontSize: 15.sp,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    maxLines: null,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: _isPosting ? null : _postComment,
                child: _isPosting
                    ? SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Color(0xFFFFD700),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFD700),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          size: 20.sp,
                          color: Colors.black,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CommentItem extends StatefulWidget {
  final VideoCommentEntity comment;
  final bool isDark;
  final Color textColor;
  final VoidCallback onReply;

  const _CommentItem({
    required this.comment,
    required this.isDark,
    required this.textColor,
    required this.onReply,
  });

  @override
  State<_CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<_CommentItem> {
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16.r,
          backgroundColor: widget.isDark ? Colors.white10 : Colors.black12,
          backgroundImage: widget.comment.photoUrl.isNotEmpty
              ? NetworkImage(widget.comment.photoUrl)
              : null,
          child: widget.comment.photoUrl.isEmpty
              ? Text(widget.comment.displayName[0].toUpperCase())
              : null,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.comment.displayName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: widget.textColor.withValues(alpha: 0.9),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    timeago.format(widget.comment.createdAt, locale: 'en_short'),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.sp,
                      color: widget.textColor.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Text(
                widget.comment.content,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  color: widget.textColor.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: _toggleLike,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w, top: 4.h, bottom: 4.h),
                      child: Row(
                        children: [
                          HugeIcon(
                            icon: _isLiked ? HugeIcons.strokeRoundedFavourite : HugeIcons.strokeRoundedFavourite,
                            size: 14.sp,
                            color: _isLiked ? Colors.red : widget.textColor.withValues(alpha: 0.4),
                          ),
                          if (_isLiked) ...[
                            SizedBox(width: 4.w),
                            Text(
                              '1',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11.sp,
                                color: widget.textColor.withValues(alpha: 0.6),
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: widget.onReply,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: Text(
                        'Reply',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: widget.textColor.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
