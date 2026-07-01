import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Resilio/l10n/app_localizations.dart';

import '../../../../../core/routing/route_names.dart';
import '../../../../../core/widgets/premium_tag_widget.dart';
import 'package:Resilio/features/customer/images/domain/entities/image_entity.dart';
import '../../../explore/domain/entities/explore_item_entity.dart';
import '../../../favorites/presentation/widgets/favorite_button.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../subscription/presentation/bloc/subscription_bloc.dart';
import '../../../subscription/presentation/bloc/subscription_state.dart';

/// Full-screen immersive image viewer.
/// Pass [images] as a list of ImageEntity OR URLs.
class ImageViewerScreen extends StatefulWidget {
  final List<dynamic> images;
  final List<String>? titles;
  final List<String>? subtitles;
  final int initialIndex;
  final String? categoryName;

  const ImageViewerScreen({
    super.key,
    required this.images,
    this.titles,
    this.subtitles,
    this.initialIndex = 0,
    this.categoryName,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  bool _showControls = true;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);

    // Hide status bar for immersive feel
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        _fadeController.forward();
      } else {
        _fadeController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // ── Full-screen vertical carousel ──────────────────────────
            GestureDetector(
              onTap: _toggleControls,
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: images.length,
                itemBuilder: (context, index, _) {
                  final item = images[index];
                  final String url;
                  if (item is ImageEntity) {
                    url = item.imageUrl;
                  } else if (item is ExploreItemEntity) url = item.imageUrl ?? '';
                  else url = item.toString();
                  
                  return SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: url.isNotEmpty
                        ? Image.network(
                            url,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                _buildPlaceholder(),
                          )
                        : _buildPlaceholder(),
                  );
                },
                options: CarouselOptions(
                  initialPage: _currentIndex,
                  viewportFraction: 1.0,
                  height: double.infinity,
                  enableInfiniteScroll: false,
                  scrollDirection: Axis.vertical,
                  pageSnapping: true,
                  onPageChanged: (index, _) {
                    setState(() => _currentIndex = index);
                  },
                ),
              ),
            ),

            // ── Top overlay ───────────────────────────────────────────
            if (_showControls)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      widget.categoryName ?? _titleForIndex(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (_isPremiumItem(images[_currentIndex])) ...[
                                    SizedBox(width: 8.w),
                                    const PremiumTagWidget(
                                      isPremium: true,
                                      top: 0,
                                      padding: 4,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            // Counter chip
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                '${_currentIndex + 1}/${images.length}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // ── Bottom overlay ────────────────────────────────────────
            // Not wrapped in [FadeTransition]: animated opacity can drop hit-testing
            // to zero so Favorite / Share taps are ignored.
            if (_showControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(
                    16.w,
                    24.h,
                    16.w,
                    MediaQuery.of(context).padding.bottom + 16.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Caption if available
                      if (_titleForIndex().isNotEmpty) ...[
                        Text(
                          _titleForIndex(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4.h),
                      ],
                      if (_subtitleForIndex().isNotEmpty) ...[
                        Text(
                          _subtitleForIndex(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildFavoriteAction(),
                              SizedBox(width: 12.w),
                              _buildActionBtn(
                                icon: Icons.share_rounded,
                                label: AppLocalizations.of(context)!.medShare,
                                onTap: _shareImage,
                              ),
                            ],
                          ),
                          _buildActionBtn(
                            icon: Icons.download_rounded,
                            label: AppLocalizations.of(context)!.medSave,
                            onTap: _downloadImage,
                          ),
                          _buildActionBtn(
                            icon: _showControls
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            label: AppLocalizations.of(context)!.medFullscreen,
                            onTap: _toggleControls,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            // ── Dot indicators (right side) ───────────────────────────
            if (_showControls && images.length > 1)
              Positioned(
                right: 12.w,
                top: 0,
                bottom: 0,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        images.length.clamp(0, 8),
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: EdgeInsets.symmetric(vertical: 3.h),
                          width: _currentIndex == i ? 8.w : 5.w,
                          height: _currentIndex == i ? 8.w : 5.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == i
                                ? Colors.white
                                : Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Stable server id for favorites; falls back to URL string if not [ImageEntity].
  String _contentIdForCurrentImage() {
    final item = widget.images[_currentIndex];
    if (item is ImageEntity) return item.id;
    if (item is ExploreItemEntity) return item.id;
    return item.toString();
  }

  bool _isPremiumItem(dynamic item) {
    if (item is ImageEntity) return item.isPremium;
    if (item is ExploreItemEntity) return item.isPremium;
    return false;
  }

  bool _hasPremiumAccess() {
    final state = context.read<SubscriptionBloc>().state;
    return state is SubscriptionLoaded && state.subscription.isActive;
  }

  void _showPremiumRequired(String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Premium subscription required to $action this content.')),
    );
    context.pushNamed(RouteNames.subscription);
  }

  /// Same chrome as [_buildActionBtn], with heart toggle next to Share.
  Widget _buildFavoriteAction() {
    final bool isPremiumLocked = _isPremiumItem(widget.images[_currentIndex]) && !_hasPremiumAccess();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isPremiumLocked)
          GestureDetector(
            onTap: () => _showPremiumRequired('favorite'),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Icon(Icons.favorite_border_rounded, color: Colors.white, size: 24.sp),
            ),
          )
        else
          FavoriteButton(
            key: ValueKey<String>(_contentIdForCurrentImage()),
            contentId: _contentIdForCurrentImage(),
            contentType: FavoriteType.image,
            size: 24.sp,
            color: Colors.white,
            bordered: true,
          ),
        SizedBox(height: 4.h),
        Text(
          'Favorite',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  String _titleForIndex() {
    final item = widget.images[_currentIndex];
    if (item is ImageEntity && item.title.isNotEmpty) return item.title;
    if (item is ExploreItemEntity && item.title.isNotEmpty) return item.title;
    
    return (widget.titles?.length ?? 0) > _currentIndex
        ? widget.titles![_currentIndex]
        : '';
  }

  String _subtitleForIndex() {
    final item = widget.images[_currentIndex];
    if (item is ImageEntity && item.author.isNotEmpty) return 'by ${item.author}';
    if (item is ExploreItemEntity && (item.subtitle?.isNotEmpty ?? false)) return 'by ${item.subtitle}';
    
    return (widget.subtitles?.length ?? 0) > _currentIndex
        ? widget.subtitles![_currentIndex]
        : '';
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade900,
      child: Center(
        child: Icon(
          Icons.image_not_supported_rounded,
          size: 48.sp,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildActionBtn({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Icon(icon, color: Colors.white, size: 24.sp),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  void _shareImage() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sharing image…',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp),
        ),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }

  void _downloadImage() {
    if (_isPremiumItem(widget.images[_currentIndex]) && !_hasPremiumAccess()) {
       _showPremiumRequired('download');
       return;
    }

    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Saving image…',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13.sp),
        ),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }
}
