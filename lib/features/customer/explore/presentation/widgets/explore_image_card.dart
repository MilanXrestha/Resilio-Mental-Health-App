import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/premium_tag_widget.dart';
import '../../domain/entities/explore_item_entity.dart';

class ExploreImageCard extends StatelessWidget {
  final ExploreItemEntity item;
  final VoidCallback? onTap;

  const ExploreImageCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.grey.shade200,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: item.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => _buildPlaceholder(isDarkMode),
                      errorWidget: (_, _, _) => _buildPlaceholder(isDarkMode),
                      memCacheWidth: 400,
                    )
                  : _buildPlaceholder(isDarkMode),

              // Gradient overlay matching dashboard style
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),

              // Title and subtitle at bottom
              Positioned(
                bottom: 12.h,
                left: 12.w,
                right: 12.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    if (item.subtitle != null &&
                        item.subtitle!.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          item.subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Premium Tag
              PremiumTagWidget(
                isPremium: item.isPremium,
                top: 8,
                left: 8,
              ),

              // Subtle border overlay
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.05),
                        width: 1.w,
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

  Widget _buildPlaceholder(bool isDarkMode) {
    return Container(
      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
      child: Center(
        child: Icon(
          Icons.image_rounded,
          size: 36,
          color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
        ),
      ),
    );
  }
}
