import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/theme_extension.dart';
import '../../domain/entities/quote_entity.dart';
import 'dart:developer';

/// A widget that displays a carousel of featured quotes with auto-scrolling and navigation.
class FeaturedQuotesWidget extends StatefulWidget {
  /// The list of featured quotes to display.
  final List<QuoteEntity> featuredQuotes;

  /// The app's theme data for consistent styling.
  final ThemeData theme;

  /// Indicates whether dark mode is enabled.
  final bool isDarkMode;

  const FeaturedQuotesWidget({
    super.key,
    required this.featuredQuotes,
    required this.theme,
    required this.isDarkMode,
  });

  @override
  FeaturedQuotesWidgetState createState() => FeaturedQuotesWidgetState();
}

class FeaturedQuotesWidgetState extends State<FeaturedQuotesWidget> {
  // Current index of the displayed quote in the PageView.
  int _currentQuoteIndex = 0;

  // Controller for the PageView to handle manual and auto-scrolling.
  final PageController _pageController = PageController();

  // Timer for auto-scrolling quotes every 10 seconds.
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    // Validate and initialize auto-scrolling if quotes are valid.
    if (widget.featuredQuotes.isNotEmpty && widget.featuredQuotes.every((quote) => quote.quoteText.isNotEmpty)) {
      log('FeaturedQuotesWidget received valid featuredQuotes: ${widget.featuredQuotes.map((q) => q.quoteText).toList()}');
      _startAutoScroll();
    } else {
      log('Warning: FeaturedQuotesWidget received invalid or empty featuredQuotes: '
          'count=${widget.featuredQuotes.length}, '
          'types=${widget.featuredQuotes.map((q) => q.runtimeType).toList()}, '
          'valid=${widget.featuredQuotes.every((quote) => quote.quoteText.isNotEmpty)}');
    }
  }

  /// Starts the auto-scrolling timer for the quote carousel.
  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (widget.featuredQuotes.isNotEmpty) {
      _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
        if (mounted && _pageController.hasClients) {
          setState(() {
            // Move to the next quote, looping back to the start if at the end.
            _currentQuoteIndex = (_currentQuoteIndex + 1) % widget.featuredQuotes.length;
            _pageController.animateToPage(
              _currentQuoteIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        }
      });
    }
  }

  @override
  void didUpdateWidget(FeaturedQuotesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset the carousel if the featured quotes list changes.
    if (widget.featuredQuotes != oldWidget.featuredQuotes || widget.featuredQuotes.length != oldWidget.featuredQuotes.length) {
      setState(() {
        _currentQuoteIndex = 0;
      });
      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
      if (widget.featuredQuotes.isNotEmpty && widget.featuredQuotes.every((quote) => quote.quoteText.isNotEmpty)) {
        _startAutoScroll();
      } else {
        log('Warning: Updated featuredQuotes invalid or empty: '
            'count=${widget.featuredQuotes.length}, '
            'types=${widget.featuredQuotes.map((q) => q.runtimeType).toList()}');
      }
    }
  }

  @override
  void dispose() {
    // Clean up timer and page controller to prevent memory leaks.
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if there are valid quotes to display.
    final surfaceColor = widget.isDarkMode 
        ? AppColors.surface.of(context) 
        : AppColors.surface.of(context);
    final textPrimaryColor = widget.isDarkMode 
        ? AppColors.textPrimary.of(context) 
        : AppColors.textPrimary.of(context);
    final textSecondaryColor = widget.isDarkMode 
        ? AppColors.textSecondary.of(context) 
        : AppColors.textSecondary.of(context);
    
    return widget.featuredQuotes.isNotEmpty && widget.featuredQuotes.every((quote) => quote.quoteText.isNotEmpty)
        ? Column(
      children: [
        // Quote carousel container.
        SizedBox(
          height: 160.h,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Container(
              decoration: BoxDecoration(
                // Use solid background from AppColors
                color: surfaceColor,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  // Bottom shadow for depth.
                  BoxShadow(
                    color: Colors.black.withAlpha(26), // 0.1 opacity
                    blurRadius: 6.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, 2.h),
                  ),
                  // Top shadow for enhanced visual effect.
                  BoxShadow(
                    color: Colors.black.withAlpha(26), // 0.1 opacity
                    blurRadius: 6.r,
                    spreadRadius: 1.r,
                    offset: Offset(0, -2.h),
                  ),
                ],
              ),
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.featuredQuotes.length,
                onPageChanged: (index) {
                  // Update current index for worm indicator.
                  setState(() => _currentQuoteIndex = index);
                },
                itemBuilder: (context, index) {
                  final quote = widget.featuredQuotes[index];
                  return InkWell(
                    // Navigate to quote detail screen on tap.
                    onTap: () {
                      // TODO: Navigate to quote detail if needed
                      // For now, we'll just show a snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('"${quote.quoteText}" - ${quote.author}'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Quote text with quotation marks.
                          RichText(
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '"',
                                  style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 18.sp,
                                    color: textPrimaryColor,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500,
                                    height: 1.0,
                                  ),
                                ),
                                TextSpan(
                                  text: quote.quoteText,
                                  style: widget.theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    color: textPrimaryColor,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: '"',
                                  style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 18.sp,
                                    color: textPrimaryColor,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500,
                                    height: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // Author name and optional icon.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (quote.authorIconUrl != null)
                                Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: Container(
                                    child: CircleAvatar(
                                      radius: 20.r,
                                      backgroundImage: CachedNetworkImageProvider(quote.authorIconUrl!),
                                      backgroundColor: widget.theme.colorScheme.surfaceContainerHighest,
                                    ),
                                  ),
                                ),
                              Flexible(
                                child: Text(
                                  quote.author,
                                  style: widget.theme.textTheme.bodyMedium?.copyWith(
                                    fontFamily: 'Poppins',
                                    color: textSecondaryColor,
                                    fontSize: 14.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        // Indicator for the current quote in the carousel.
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.featuredQuotes.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6.h,
            dotWidth: 6.w,
            expansionFactor: 3,
            spacing: 6.w,
            activeDotColor: widget.theme.colorScheme.primary,
            dotColor: textSecondaryColor.withValues(alpha: 0.3),
          ),
        ),
      ],
    )
        : Container(
      // Empty state when no valid quotes are available.
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26), // 0.1 opacity
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
          // Top shadow for empty state container.
          BoxShadow(
            color: Colors.black.withAlpha(26), // 0.1 opacity
            blurRadius: 6.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: Text(
        'No featured quotes available. Try refreshing or checking your preferences.',
        style: widget.theme.textTheme.bodyMedium?.copyWith(
          fontFamily: 'Poppins',
          color: textSecondaryColor,
          fontSize: 13.sp,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}