import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';
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
                '⚠️ No inspirational images available',
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inspirational Images',
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Beautiful wallpapers for your wellness journey',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _SeeAllButton(
                    onTap: () => context.push('/images'),
                  ),
                ],
              ),
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
                  return SizedBox(
                    width: 260.w,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: _buildImageCard(context, image),
                    ),
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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: InkWell(
        onTap: () => _showImageDetail(context, image),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: Image.network(
                    image.thumbnailUrl.isNotEmpty ? image.thumbnailUrl : image.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade200,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 32.r,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              // Info section
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      image.title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: _getTypeColor(context, image.imageType).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            image.imageTypeString,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w500,
                              color: _getTypeColor(context, image.imageType),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
        'See All',
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
                child: Image.network(
                  image.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 400.h,
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
                  color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                ),
              ),
              
              SizedBox(height: 12.h),
              
              // Type badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getTypeColor(context, image.imageType).withOpacity(0.2),
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
                    color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey,
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
                      const SnackBar(content: Text('Wallpaper feature coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Set as Wallpaper'),
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
