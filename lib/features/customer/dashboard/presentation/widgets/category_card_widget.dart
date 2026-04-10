import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/theme_extension.dart';
import '../../../categories/domain/entities/category_entity.dart';

/// Category card widget following the sleek reference app UI
class CategoryCardWidget extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback? onTap;

  const CategoryCardWidget({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    return SizedBox(
      width: 145.w,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
            width: 1.w,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              if (isDarkMode)
                BoxShadow(
                  color: context.surfaceColor.withValues(alpha: 0.1),
                  blurRadius: 4.r,
                  spreadRadius: 0.5.r,
                  offset: Offset(0, 1.h),
                )
              else
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4.r,
                  spreadRadius: 0.5.r,
                  offset: Offset(0, -1.h),
                ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Image
              if (category.imageUrl.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: category.imageUrl,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 200),
                  fadeOutDuration: const Duration(milliseconds: 200),
                  placeholder: (_, __) => Container(
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[400],
                  ),
                  errorWidget: (_, __, ___) => _buildErrorWidget(context, isDarkMode),
                )
              else
                _buildErrorWidget(context, isDarkMode),

              // Overlay Gradient/Dim
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.black.withOpacity(0.6)
                      : Colors.black.withOpacity(0.4),
                ),
              ),

              // Title Positioned at the bottom
              Positioned(
                bottom: 6.h,
                left: 6.w,
                right: 6.w,
                child: Text(
                  category.name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),

              // InkWell for tapping
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(onTap: onTap),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, bool isDarkMode) {
    return Container(
      color: isDarkMode
          ? context.primaryColor.withOpacity(0.2)
          : Colors.grey.shade100,
      child: Icon(
        Icons.category_rounded,
        size: 30.sp,
        color: isDarkMode ? context.textSecondaryColor : Colors.grey.shade600,
      ),
    );
  }
}
