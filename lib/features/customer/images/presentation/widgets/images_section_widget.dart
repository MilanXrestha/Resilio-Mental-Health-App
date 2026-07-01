import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:Resilio/l10n/app_localizations.dart';

import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../categories/domain/entities/category_card_entity.dart';
import '../../../dashboard/presentation/widgets/section_header_widget.dart';
import '../../../../../core/widgets/premium_tag_widget.dart';
import '../../domain/entities/image_entity.dart';
import '../bloc/image_bloc.dart';
import '../bloc/image_state.dart';

class ImagesSection extends StatelessWidget {
  const ImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        if (state is ImageError) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '❌ Images Error: ${state.message}',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: Colors.red.shade700,
                ),
              ),
            ),
          );
        }

        List<ImageEntity> images = [];
        if (state is ImageLoaded) {
          images = state.images;
        }

        if (images.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                AppLocalizations.of(context)!.medNoInspirationalImagesAvailable,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.sp,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeaderWidget(
              title: AppLocalizations.of(context)!.medInspirationalImages,
              subtitle: AppLocalizations.of(context)!.medBeautifulWallpapersInspire,
              onSeeAll: () {
                context.pushNamed(
                  RouteNames.categoryDetail,
                  extra: const CategoryCardEntity(
                    id: '',
                    name: 'Inspirational Images',
                    imageUrl: '',
                    description: 'All inspirational images',
                  ),
                  queryParameters: {'contentType': 'image'},
                );
              },
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 280.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: images.length > 6 ? 6 : images.length,
                itemBuilder: (context, index) {
                  final image = images[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: _buildImageCard(context, image),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildImageCard(BuildContext context, ImageEntity image) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 150.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: isDarkMode ? context.surfaceColor : context.backgroundColor,
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
            CachedNetworkImage(
              imageUrl: image.thumbnailUrl.isNotEmpty
                  ? image.thumbnailUrl
                  : image.imageUrl,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) {
                return Container(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorWidget: (_, _, _) => Container(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 32.r,
                  color: Colors.grey.shade400,
                ),
              ),
            ),

            // Gradient Overlay for text readability
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

            // Content
            Positioned(
              bottom: 12.h,
              left: 12.w,
              right: 12.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    image.title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getTypeColor(
                        context,
                        image.imageType,
                      ).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      image.imageTypeString,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Premium Tag
            PremiumTagWidget(isPremium: image.isPremium, top: 8, left: 8),

            // Subtle border highlight
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isDarkMode
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.black.withValues(alpha: 0.05),
                      width: 1.w,
                    ),
                  ),
                ),
              ),
            ),

            // Tap area
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Find index and navigate to dedicated Image Viewer
                    final blocState = context.read<ImageBloc>().state;
                    List<ImageEntity> allImages = [image];
                    if (blocState is ImageLoaded) {
                      allImages = blocState.images;
                    }
                    final index = allImages.indexOf(image);

                    context.pushNamed(
                      RouteNames.imageViewer,
                      extra: {
                        'images': allImages,
                        'initialIndex': index != -1 ? index : 0,
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(BuildContext context, ImageType type) {
    switch (type) {
      case ImageType.motivation:
        return const Color(0xFFFF6B6B);
      case ImageType.nature:
        return const Color(0xFF4ECDC4);
      case ImageType.quotes:
        return const Color(0xFFFFE66D);
      case ImageType.abstract:
        return const Color(0xFFA8E6CF);
      case ImageType.spiritual:
        return const Color(0xFFDDA0DD);
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  void _showImageDetail(BuildContext context, ImageEntity image) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ImageDetailSheet(image: image),
    );
  }
}

class _SeeAllButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SeeAllButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        AppLocalizations.of(context)!.medSeeAll,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _ImageDetailSheet extends StatelessWidget {
  final ImageEntity image;

  const _ImageDetailSheet({required this.image});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.all(20.w),
            children: [
              // Handle
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Full image
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  imageUrl: image.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 400.h,
                  errorWidget: (_, _, _) => Container(
                    height: 400.h,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image_rounded),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Title
              Text(
                image.title,
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.black,
                ),
              ),

              SizedBox(height: 12.h),

              // Type badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getTypeColor(
                    context,
                    image.imageType,
                  ).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  image.imageTypeString,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: _getTypeColor(context, image.imageType),
                  ),
                ),
              ),

              if (image.description.isNotEmpty) ...[
                SizedBox(height: 16.h),
                Text(
                  image.description,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    color:
                        Theme.of(context).textTheme.bodyMedium?.color ??
                        Colors.grey,
                    height: 1.6,
                  ),
                ),
              ],

              SizedBox(height: 24.h),

              // Action button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.medWallpaperComingSoon),
                      ),
                    );
                  },
                  icon: const Icon(Icons.download_outlined),
                  label: Text(AppLocalizations.of(context)!.medSetAsWallpaper),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }

  Color _getTypeColor(BuildContext context, ImageType type) {
    switch (type) {
      case ImageType.motivation:
        return const Color(0xFFFF6B6B);
      case ImageType.nature:
        return const Color(0xFF4ECDC4);
      case ImageType.quotes:
        return const Color(0xFFFFE66D);
      case ImageType.abstract:
        return const Color(0xFFA8E6CF);
      case ImageType.spiritual:
        return const Color(0xFFDDA0DD);
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }
}
