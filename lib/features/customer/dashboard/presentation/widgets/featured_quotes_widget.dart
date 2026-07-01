import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/theme_extension.dart';
import '../../domain/entities/quote_entity.dart';

class FeaturedQuotesWidget extends StatefulWidget {
  final List<QuoteEntity> featuredQuotes;
  final ThemeData theme;
  final bool isDarkMode;

  const FeaturedQuotesWidget({
    super.key,
    required this.featuredQuotes,
    required this.theme,
    required this.isDarkMode,
  });

  @override
  State<FeaturedQuotesWidget> createState() => _FeaturedQuotesWidgetState();
}

class _FeaturedQuotesWidgetState extends State<FeaturedQuotesWidget> {
  // ── State ────────────────────────────────────────────────────────────────
  int _currentIndex = 0;
  double _currentPage = 0;
  late final PageController _pageController;
  Timer? _autoScrollTimer;

  // Calming wellness gradients
  static const _gradients = <List<Color>>[
    [Color(0xFF0D9488), Color(0xFF0F766E)], // Teal
    [Color(0xFF6366F1), Color(0xFF4F46E5)], // Indigo
    [Color(0xFF8B5CF6), Color(0xFF7C3AED)], // Purple
    [Color(0xFF0EA5E9), Color(0xFF0284C7)], // Sky
    [Color(0xFF059669), Color(0xFF047857)], // Emerald
    [Color(0xFFD97706), Color(0xFFB45309)], // Amber
    [Color(0xFFDB2777), Color(0xFFBE185D)], // Pink
    [Color(0xFF7C3AED), Color(0xFF6D28D9)], // Violet
  ];

  // ── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.86);
    _pageController.addListener(_onScroll);
    if (_validQuotes) _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant FeaturedQuotesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.featuredQuotes.length != oldWidget.featuredQuotes.length) {
      _currentIndex = 0;
      _currentPage = 0;
      if (_pageController.hasClients) _pageController.jumpToPage(0);
      _validQuotes ? _startAutoScroll() : _autoScrollTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  bool get _validQuotes =>
      widget.featuredQuotes.isNotEmpty &&
          widget.featuredQuotes.every((q) => q.quoteText.isNotEmpty);

  List<QuoteEntity> get _displayedQuotes => widget.featuredQuotes.take(4).toList();

  void _onScroll() {
    if (!mounted) return;
    final page = _pageController.page;
    if (page != null) setState(() => _currentPage = page);
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    final count = _displayedQuotes.length;
    if (count <= 1) return;
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !_pageController.hasClients) return;
      final next = (_currentIndex + 1) % count;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    });
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (!_validQuotes) return const SizedBox.shrink();

    return Column(
      children: [
        // ── Carousel ────────────────────────────────────────────────
        SizedBox(
          height: 230.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _displayedQuotes.length,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemBuilder: (context, index) {
              final quote = _displayedQuotes[index];
              final colors = _gradients[index % _gradients.length];

              // Scale: current card = 1.0, adjacent cards = 0.92
              final diff = (_currentPage - index).abs();
              final scale = (1 - diff * 0.08).clamp(0.92, 1.0);

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: scale, end: scale),
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                builder: (_, value, child) =>
                    Transform.scale(scale: value, child: child),
                child: _QuoteCard(
                  quote: quote,
                  gradientColors: colors,
                  onTap: () {
                    context.pushNamed(
                      RouteNames.contentViewer,
                      extra: {
                        'quotes': _displayedQuotes,
                        'initialIndex': index,
                        'title': 'Daily Inspiration',
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),

        SizedBox(height: 16.h),

        // ── Dots ────────────────────────────────────────────────────
        SmoothPageIndicator(
          controller: _pageController,
          count: _displayedQuotes.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6.h,
            dotWidth: 6.w,
            expansionFactor: 3.5,
            spacing: 6.w,
            activeDotColor: AppColors.primary.of(context),
            dotColor: AppColors.textSecondary.of(context).withOpacity(0.25),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SINGLE QUOTE CARD
// ─────────────────────────────────────────────────────────────────────────────

class _QuoteCard extends StatelessWidget {
  final QuoteEntity quote;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _QuoteCard({
    required this.quote,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24.r),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.white10,
            highlightColor: Colors.white10,
            child: Stack(
              children: [
                // Decorative quotes background
                Positioned(
                  left: -10.w,
                  top: -15.h,
                  child: Opacity(
                    opacity: 0.15,
                    child: Transform(
                      transform: Matrix4.rotationY(3.14159), // Flipped horizontally
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.format_quote,
                        size: 100.sp,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -10.w,
                  bottom: -10.h,
                  child: Opacity(
                    opacity: 0.15,
                    child: Transform(
                      transform: Matrix4.rotationY(0),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.format_quote,
                        size: 100.sp,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 22.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Quote icon
                      Icon(
                        Icons.format_quote_rounded,
                        size: 30.sp,
                        color: Colors.white.withOpacity(0.45),
                      ),
                      
                      SizedBox(height: 10.h),
                      
                      // Quote text
                      Flexible(
                        child: RichText(
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '"',
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: quote.quoteText,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: '"',
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Divider
                      Container(
                        width: 36.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(1.r),
                        ),
                      ),

                      SizedBox(height: 14.h),

                      // Author row
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (quote.authorIconUrl != null) ...[
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 1.5.w,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 14.r,
                                backgroundColor:
                                Colors.white.withOpacity(0.15),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: quote.authorIconUrl!,
                                    fit: BoxFit.cover,
                                    width: 28.r,
                                    height: 28.r,
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.person_rounded,
                                      size: 16.sp,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                          ],
                          Flexible(
                            child: Text(
                              '— ${quote.author}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.85),
                              ),
                              overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}