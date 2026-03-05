import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../bloc/image_bloc.dart';
import '../bloc/image_event.dart';
import '../bloc/image_state.dart';
import '../widgets/image_card_widget.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inspirational Images',
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ImageBloc>().add(const RefreshImages());
            },
          ),
        ],
      ),
      body: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageLoading && state is! ImageLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: context.primaryColor),
                  SizedBox(height: 16.h),
                  Text(
                    'Loading images...',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ImageError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.r,
                    color: Colors.red.shade300,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Error loading images',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<ImageBloc>().add(const LoadFeaturedImages(limit: 20));
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ImageLoaded && state.images.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 64.r,
                    color: context.textSecondaryColor.withOpacity(0.5),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No images available',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Check back later for new inspirational content',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ImageLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ImageBloc>().add(const RefreshImages());
              },
              color: context.primaryColor,
              child: GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 1.2,
                ),
                itemCount: state.images.length,
                itemBuilder: (context, index) {
                  final image = state.images[index];
                  return ImageCardWidget(image: image);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
