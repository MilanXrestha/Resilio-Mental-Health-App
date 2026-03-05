import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/image_entity.dart';

class ImageCardWidget extends StatelessWidget {
  final ImageEntity image;
  final GlobalKey _imageKey = GlobalKey();

  ImageCardWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: InkWell(
        onTap: () => _showImageDetail(context),
        borderRadius: BorderRadius.circular(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: RepaintBoundary(
                key: _imageKey,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: Image.network(
                    image.thumbnailUrl.isNotEmpty ? image.thumbnailUrl : image.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
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
                          size: 48.r,
                          color: Colors.grey.shade400,
                        ),
                      );
                    },
                  ),
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
                      fontSize: 14.sp,
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
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: _getTypeColor(context).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          image.imageTypeString,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: _getTypeColor(context),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (image.downloadCount > 0)
                        Row(
                          children: [
                            Icon(
                              Icons.download_outlined,
                              size: 14.r,
                              color: context.textSecondaryColor,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${image.downloadCount}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.sp,
                                color: context.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(BuildContext context) {
    switch (image.imageType) {
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

  void _showImageDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ImageDetailSheet(image: image, imageKey: _imageKey),
    );
  }
}

class _ImageDetailSheet extends StatelessWidget {
  final ImageEntity image;
  final GlobalKey imageKey;

  const _ImageDetailSheet({
    required this.image,
    required this.imageKey,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              
              // Action buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _ActionButton(
                      icon: Icons.download_outlined,
                      label: 'Set Wallpaper',
                      onTap: () => _captureAndSave(context),
                    ),
                    SizedBox(width: 12.w),
                    _ActionButton(
                      icon: Icons.info_outline,
                      label: 'Info',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              
              Divider(height: 1.h),
              
              // Image and details
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.all(20.w),
                  children: [
                    // Full image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.network(
                        image.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey.shade200,
                            height: 300.h,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
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
                        color: _getTypeColor(context).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        image.imageTypeString,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: _getTypeColor(context),
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
                          color: context.textSecondaryColor,
                          height: 1.6,
                        ),
                      ),
                    ],
                    
                    if (image.author.isNotEmpty) ...[
                      SizedBox(height: 24.h),
                      Divider(),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          if (image.authorIconUrl.isNotEmpty) ...[
                            CircleAvatar(
                              radius: 20.r,
                              backgroundImage: NetworkImage(image.authorIconUrl),
                            ),
                            SizedBox(width: 12.w),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  image.author,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                                  ),
                                ),
                                Text(
                                  'Creator',
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
                    ],
                    
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getTypeColor(BuildContext context) {
    switch (image.imageType) {
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

  Future<void> _captureAndSave(BuildContext context) async {
    try {
      // Show message - gallery save to be implemented with native code or compatible package
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wallpaper download feature coming soon!'),
          duration: Duration(seconds: 2),
        ),
      );
      
      // TODO: Implement native gallery save using platform channels or find AGP-compatible package
      // For now, users can screenshot or use the image URL directly
    } catch (e) {
      print('Error saving image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save image')),
      );
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24.r,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
