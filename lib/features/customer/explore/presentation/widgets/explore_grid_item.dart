import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/explore_item_entity.dart';

class ExploreGridItem extends StatelessWidget {
  final ExploreItemEntity item;
  final VoidCallback? onTap;

  const ExploreGridItem({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: context.borderColor.withOpacity(0.2),
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Important: use min size
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with fixed aspect ratio
            AspectRatio(
              aspectRatio: _getImageAspectRatio(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: _buildImage(context),
                  ),
                  // Type badge
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: _TypeBadge(type: item.type),
                  ),
                  // Duration badge (for audio/video)
                  if (item.formattedDuration != null)
                    Positioned(
                      bottom: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          item.formattedDuration!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  // Featured badge
                  if (item.isFeatured)
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.star_rounded,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  // Premium badge
                  if (item.isPremium && !item.isFeatured)
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.workspace_premium_rounded,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  // Play overlay for media types
                  if (_isMediaType)
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8.r,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            size: 24.sp,
                            color: context.primaryColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Info section with fixed padding
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    _displayTitle,
                    maxLines: _getTitleMaxLines(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: item.type == ExploreItemType.quote
                          ? 'PlayfairDisplay'
                          : 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                      height: 1.3,
                    ),
                  ),
                  // Subtitle
                  if (item.subtitle != null && item.subtitle!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      item.subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                  // Tags
                  if (item.tags.isNotEmpty && item.type == ExploreItemType.tip) ...[
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 4.w,
                      runSpacing: 4.h,
                      children: item.tags.take(2).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: context.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w500,
                              color: context.primaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Get aspect ratio based on item type for visual variety
  double _getImageAspectRatio() {
    switch (item.type) {
      case ExploreItemType.shortVideo:
        return 9 / 12; // Taller for shorts
      case ExploreItemType.longVideo:
        return 16 / 10; // Wider for videos
      case ExploreItemType.quote:
        return 4 / 3; // Square-ish for quotes
      case ExploreItemType.audio:
        return 1; // Square for audio
      case ExploreItemType.image:
        return 4 / 5; // Portrait for images
      case ExploreItemType.tip:
        return 3 / 2; // Landscape for tips
      case ExploreItemType.category:
        return 4 / 3;
    }
  }

  /// Get max lines for title based on type
  int _getTitleMaxLines() {
    switch (item.type) {
      case ExploreItemType.quote:
        return 3;
      case ExploreItemType.tip:
        return 2;
      default:
        return 2;
    }
  }

  Widget _buildImage(BuildContext context) {
    final imageUrl = item.thumbnailUrl ?? item.imageUrl;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (_, _) => _buildPlaceholder(context),
        errorWidget: (_, _, _) => _buildPlaceholder(context),
      );
    }

    return _buildPlaceholder(context);
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getTypeColor(context).withOpacity(0.3),
            _getTypeColor(context).withOpacity(0.1),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          _getTypeIcon(),
          size: 36.sp,
          color: _getTypeColor(context).withOpacity(0.6),
        ),
      ),
    );
  }

  bool get _isMediaType =>
      item.type == ExploreItemType.audio ||
          item.type == ExploreItemType.shortVideo ||
          item.type == ExploreItemType.longVideo;

  String get _displayTitle {
    if (item.type == ExploreItemType.quote) {
      final text = item.title;
      if (text.length > 80) {
        return '"${text.substring(0, 77)}..."';
      }
      return '"$text"';
    }
    return item.title;
  }

  Color _getTypeColor(BuildContext context) {
    switch (item.type) {
      case ExploreItemType.audio:
        return const Color(0xFF6366F1);
      case ExploreItemType.shortVideo:
        return const Color(0xFFEC4899);
      case ExploreItemType.longVideo:
        return const Color(0xFF8B5CF6);
      case ExploreItemType.quote:
        return const Color(0xFF0D9488);
      case ExploreItemType.tip:
        return const Color(0xFFF59E0B);
      case ExploreItemType.image:
        return const Color(0xFF10B981);
      case ExploreItemType.category:
        return context.primaryColor;
    }
  }

  IconData _getTypeIcon() {
    switch (item.type) {
      case ExploreItemType.audio:
        return Icons.headphones_rounded;
      case ExploreItemType.shortVideo:
        return Icons.play_circle_outline_rounded;
      case ExploreItemType.longVideo:
        return Icons.ondemand_video_rounded;
      case ExploreItemType.quote:
        return Icons.format_quote_rounded;
      case ExploreItemType.tip:
        return Icons.lightbulb_outline_rounded;
      case ExploreItemType.image:
        return Icons.image_rounded;
      case ExploreItemType.category:
        return Icons.category_rounded;
    }
  }
}

class _TypeBadge extends StatelessWidget {
  final ExploreItemType type;

  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _getColor(context),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: _getColor(context).withOpacity(0.3),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(),
            size: 12.sp,
            color: Colors.white,
          ),
          SizedBox(width: 4.w),
          Text(
            _getLabel(),
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _getColor(BuildContext context) {
    switch (type) {
      case ExploreItemType.audio:
        return const Color(0xFF6366F1);
      case ExploreItemType.shortVideo:
        return const Color(0xFFEC4899);
      case ExploreItemType.longVideo:
        return const Color(0xFF8B5CF6);
      case ExploreItemType.quote:
        return const Color(0xFF0D9488);
      case ExploreItemType.tip:
        return const Color(0xFFF59E0B);
      case ExploreItemType.image:
        return const Color(0xFF10B981);
      case ExploreItemType.category:
        return context.primaryColor;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case ExploreItemType.audio:
        return Icons.headphones_rounded;
      case ExploreItemType.shortVideo:
        return Icons.play_circle_outline_rounded;
      case ExploreItemType.longVideo:
        return Icons.ondemand_video_rounded;
      case ExploreItemType.quote:
        return Icons.format_quote_rounded;
      case ExploreItemType.tip:
        return Icons.lightbulb_outline_rounded;
      case ExploreItemType.image:
        return Icons.image_rounded;
      case ExploreItemType.category:
        return Icons.category_rounded;
    }
  }

  String _getLabel() {
    switch (type) {
      case ExploreItemType.audio:
        return 'Audio';
      case ExploreItemType.shortVideo:
        return 'Short';
      case ExploreItemType.longVideo:
        return 'Video';
      case ExploreItemType.quote:
        return 'Quote';
      case ExploreItemType.tip:
        return 'Tip';
      case ExploreItemType.image:
        return 'Image';
      case ExploreItemType.category:
        return 'Category';
    }
  }
}