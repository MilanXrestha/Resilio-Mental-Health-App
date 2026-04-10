import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../audio/domain/entities/audio_entity.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../../dashboard/domain/entities/quote_entity.dart';
import '../../../images/domain/entities/image_entity.dart';
import '../../../video/domain/entities/video_entity.dart';
import '../../../categories/domain/entities/category_card_entity.dart';
import '../../../categories/presentation/screens/category_detail_screen.dart';
import '../../../tips/domain/entities/tip_entity.dart';

import '../../../dashboard/presentation/widgets/audio_card_widget.dart';
import '../../../dashboard/presentation/widgets/category_card_widget.dart';
import '../../../dashboard/presentation/widgets/long_video_card_widget.dart';
import '../../../dashboard/presentation/widgets/quote_card_widget.dart';
import '../../../dashboard/presentation/widgets/section_header_widget.dart';
import '../../../dashboard/presentation/widgets/short_video_card_widget.dart';
import '../../../tips/presentation/widgets/tip_card_widget.dart';

import '../../domain/entities/explore_item_entity.dart';
import '../bloc/explore_bloc.dart';
import '../widgets/explore_search_bar.dart';
import '../widgets/explore_filter_sheet.dart';
import '../widgets/explore_image_card.dart';
import '../widgets/explore_suggestions_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExploreBloc>()..add(const LoadExploreItems()),
      child: const _ExploreView(),
    );
  }
}

class _ExploreView extends StatefulWidget {
  const _ExploreView();

  @override
  State<_ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<_ExploreView> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!mounted) return;
    setState(() {
      _showSuggestions = _searchFocusNode.hasFocus;
    });
  }

  void _showFilterSheet(BuildContext context, ExploreLoaded state) {
    final bloc = context.read<ExploreBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ExploreFilterSheet(
        currentFilter: state.filter,
        onApply: (filter) {
          bloc.add(UpdateFilters(filter));
        },
        onClear: () {
          bloc.add(const ClearFilters());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            if (state is ExploreLoading) {
              return _buildLoadingState(context);
            }

            if (state is ExploreError) {
              return _buildErrorState(context, state.message);
            }

            if (state is ExploreLoaded) {
              return _buildLoadedState(context, state);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    final baseColor = isDarkMode ? context.surfaceColor : context.backgroundColor;
    final highlightColor = isDarkMode ? context.surfaceColor.withOpacity(0.5) : Colors.grey.shade100;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header placeholder
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 32.h, 20.w, 16.h),
            child: Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 150.w, height: 32.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r))),
                  SizedBox(height: 8.h),
                  Container(width: 200.w, height: 16.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.r))),
                  SizedBox(height: 24.h),
                  Container(width: double.infinity, height: 50.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r))),
                  SizedBox(height: 16.h),
                  Row(
                    children: List.generate(4, (index) => Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Container(width: 80.w, height: 36.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r))),
                    )),
                  ),
                ],
              ),
            ),
          ),
          
          // Section placeholders
          ...List.generate(3, (index) => _buildShimmerSection(context, baseColor, highlightColor)),
        ],
      ),
    );
  }

  Widget _buildShimmerSection(BuildContext context, Color baseColor, Color highlightColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 36.h, 20.w, 16.h),
          child: Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 140.w, height: 24.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.r))),
                Container(width: 60.w, height: 16.h, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.r))),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 220.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
            itemBuilder: (_, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: 160.w,
                    height: 150.h,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
                  ),
                ),
                SizedBox(height: 12.h),
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: 130.w,
                    height: 14.h,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.r)),
                  ),
                ),
                SizedBox(height: 6.h),
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: 90.w,
                    height: 12.h,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4.r)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: context.errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 48.sp,
                color: context.errorColor,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Something went wrong',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                color: context.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            FilledButton.icon(
              onPressed: () {
                context.read<ExploreBloc>().add(const LoadExploreItems());
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
              style: FilledButton.styleFrom(
                backgroundColor: context.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, ExploreLoaded state) {
    final itemsByType = state.itemsByType;

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ExploreBloc>().add(const RefreshExploreItems());
      },
      color: context.primaryColor,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, state),
            if (_showSuggestions && !state.isSearchActive)
              _buildSuggestions(context, state)
            else if (state.hasResults)
              _buildSectionedContent(context, state, itemsByType)
            else
              _buildEmptyState(context, state.isSearchActive),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ExploreLoaded state) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Explore',
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: context.textPrimaryColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Discover content for your wellness journey',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: context.textSecondaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          ExploreSearchBar(
            focusNode: _searchFocusNode,
            initialQuery: state.filter.searchQuery,
            onChanged: (query) {
              context.read<ExploreBloc>().add(UpdateSearchQuery(query));
            },
            onSubmitted: () {
              if (state.filter.searchQuery?.isNotEmpty ?? false) {
                context.read<ExploreBloc>().add(
                  SubmitSearch(state.filter.searchQuery!),
                );
              }
              _searchFocusNode.unfocus();
              setState(() => _showSuggestions = false);
            },
            onClear: () {
              context.read<ExploreBloc>().add(const ClearSearch());
            },
            onFilterTap: () => _showFilterSheet(context, state),
            activeFilterCount: state.filter.activeFilterCount,
          ),
          SizedBox(height: 12.h),
          _buildQuickFilters(context, state),
        ],
      ),
    );
  }

  Widget _buildQuickFilters(BuildContext context, ExploreLoaded state) {
    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _QuickFilterChip(
            label: 'All',
            isSelected: state.filter.types.isEmpty,
            onTap: () {
              context.read<ExploreBloc>().add(const ClearFilters());
            },
          ),
          SizedBox(width: 8.w),
          ...ExploreItemType.values.map((type) {
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: _QuickFilterChip(
                label: _getTypeLabel(type),
                icon: _getTypeIcon(type),
                color: _getTypeColor(type),
                isSelected: state.filter.types.contains(type),
                onTap: () {
                  context.read<ExploreBloc>().add(ToggleTypeFilter(type));
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSuggestions(BuildContext context, ExploreLoaded state) {
    return ExploreSuggestionsWidget(
      recentSearches: state.recentSearches,
      trendingSearches: state.trendingSearches,
      onSuggestionTap: (query) {
        context.read<ExploreBloc>().add(SelectSuggestedSearch(query));
        _searchFocusNode.unfocus();
        setState(() => _showSuggestions = false);
      },
      onClearRecent: () {
        context.read<ExploreBloc>().add(const ClearRecentSearches());
      },
    );
  }

  Widget _buildSectionedContent(
      BuildContext context,
      ExploreLoaded state,
      Map<ExploreItemType, List<ExploreItemEntity>> itemsByType,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Audio Section
        if (itemsByType.containsKey(ExploreItemType.audio))
          _AudioSection(
            items: itemsByType[ExploreItemType.audio]!,
            onSeeAll: () => _navigateToTypeList(context, ExploreItemType.audio),
          ),

        // Short Videos Section
        if (itemsByType.containsKey(ExploreItemType.shortVideo))
          _ShortVideosSection(
            items: itemsByType[ExploreItemType.shortVideo]!,
            onSeeAll: () => _navigateToTypeList(context, ExploreItemType.shortVideo),
          ),

        // Quotes Section
        if (itemsByType.containsKey(ExploreItemType.quote))
          _QuotesSection(
            items: itemsByType[ExploreItemType.quote]!,
            onSeeAll: () => _navigateToTypeList(context, ExploreItemType.quote),
          ),

        // Tips Section
        if (itemsByType.containsKey(ExploreItemType.tip))
          _TipsSection(
            items: itemsByType[ExploreItemType.tip]!,
            onSeeAll: () => _navigateToTypeList(context, ExploreItemType.tip),
          ),

        // Images Section
        if (itemsByType.containsKey(ExploreItemType.image))
          _ImagesSection(
            items: itemsByType[ExploreItemType.image]!,
            onSeeAll: () => _navigateToTypeList(context, ExploreItemType.image),
          ),

        // Long Videos Section
        if (itemsByType.containsKey(ExploreItemType.longVideo))
          _LongVideosSection(
            items: itemsByType[ExploreItemType.longVideo]!,
            onSeeAll: () => _navigateToTypeList(context, ExploreItemType.longVideo),
          ),

        // Categories Section
        if (itemsByType.containsKey(ExploreItemType.category))
          _CategoriesSection(
            items: itemsByType[ExploreItemType.category]!,
            onSeeAll: () => _navigateToTypeList(context, ExploreItemType.category),
          ),

        SizedBox(height: 100.h),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isSearchActive) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/no_data.json',
              width: 200.w,
              height: 200.h,
            ),
            SizedBox(height: 16.h),
            Text(
              isSearchActive ? 'No Results Found' : 'Nothing to Explore',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: context.textPrimaryColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              isSearchActive
                  ? 'Try different keywords or filters'
                  : 'Check back later for new content',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                color: context.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (isSearchActive) ...[
              SizedBox(height: 24.h),
              TextButton.icon(
                onPressed: () {
                  context.read<ExploreBloc>().add(const ClearSearch());
                  context.read<ExploreBloc>().add(const ClearFilters());
                },
                icon: Icon(Icons.refresh_rounded, color: context.primaryColor),
                label: Text(
                  'Clear Search',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.primaryColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _navigateToTypeList(BuildContext context, ExploreItemType type) {
    // Navigate to full list of specific type
    // You can implement a separate screen or just filter
    context.read<ExploreBloc>().add(UpdateFilters(
      ExploreFilter(types: [type]),
    ));
  }

  String _getTypeLabel(ExploreItemType type) {
    switch (type) {
      case ExploreItemType.audio:
        return 'Audio';
      case ExploreItemType.shortVideo:
        return 'Shorts';
      case ExploreItemType.longVideo:
        return 'Videos';
      case ExploreItemType.quote:
        return 'Quotes';
      case ExploreItemType.tip:
        return 'Tips';
      case ExploreItemType.image:
        return 'Images';
      case ExploreItemType.category:
        return 'Categories';
    }
  }

  IconData _getTypeIcon(ExploreItemType type) {
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

  Color _getTypeColor(ExploreItemType type) {
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
        return const Color(0xFF3B82F6);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// QUICK FILTER CHIP
// ─────────────────────────────────────────────────────────────────────────────

class _QuickFilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final bool isSelected;
  final VoidCallback onTap;

  const _QuickFilterChip({
    required this.label,
    this.icon,
    this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? context.primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? chipColor : context.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? chipColor : context.borderColor.withOpacity(0.3),
            width: 1.5.w,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: chipColor.withOpacity(0.3),
              blurRadius: 8.r,
              offset: Offset(0, 3.h),
            ),
          ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16.sp,
                color: isSelected ? Colors.white : context.textSecondaryColor,
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : context.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION HEADER
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onSeeAll;

  const _SectionHeader({
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        SectionHeaderWidget(
          title: title,
          subtitle: subtitle ?? '',
          onSeeAll: onSeeAll,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AUDIO SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _AudioSection extends StatelessWidget {
  final List<ExploreItemEntity> items;
  final VoidCallback? onSeeAll;

  const _AudioSection({required this.items, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Calming Audio',
          subtitle: 'Meditation & wellness sessions',
          icon: Icons.headphones_rounded,
          iconColor: const Color(0xFF6366F1),
          onSeeAll: onSeeAll,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 190.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final item = items[index];
              final audio = _toAudioEntity(item);
              return AudioCardWidget(
                track: audio,
                onTap: () => context.pushNamed(RouteNames.mediaPlayer, extra: audio),
              );
            },
          ),
        ),
      ],
    );
  }

  AudioEntity _toAudioEntity(ExploreItemEntity item) {
    return AudioEntity(
      id: item.id,
      title: item.title,
      description: item.description ?? '',
      artistName: item.subtitle ?? '',
      audioUrl: item.metadata?['audioUrl'] ?? '',
      coverImageUrl: item.imageUrl ?? '',
      thumbnailUrl: item.thumbnailUrl ?? '',
      durationSeconds: item.durationSeconds ?? 0,
      categoryId: item.categoryIds.isNotEmpty ? item.categoryIds.first : '',
      moodTags: item.tags,
      isFeatured: item.isFeatured,
      isPremium: item.isPremium,
      sortOrder: 0,
      createdAt: item.createdAt,
      updatedAt: item.createdAt,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHORT VIDEOS SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _ShortVideosSection extends StatelessWidget {
  final List<ExploreItemEntity> items;
  final VoidCallback? onSeeAll;

  const _ShortVideosSection({required this.items, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Short Videos',
          subtitle: 'Quick mindfulness moments',
          icon: Icons.play_circle_outline_rounded,
          iconColor: const Color(0xFFEC4899),
          onSeeAll: onSeeAll,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 220.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return ShortVideoCardWidget(
                video: _toVideoEntity(item, VideoType.shortForm),
                onTap: () {
                  final videos = items.map((i) => _toVideoEntity(i, VideoType.shortForm)).toList();
                  context.pushNamed(
                    RouteNames.shortsPlayer,
                    extra: videos,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  VideoEntity _toVideoEntity(ExploreItemEntity item, VideoType type) {
    return VideoEntity(
      id: item.id,
      title: item.title,
      description: item.description ?? '',
      artistName: item.subtitle ?? '',
      videoUrl: item.metadata?['videoUrl'] ?? '',
      thumbnailUrl: item.thumbnailUrl ?? '',
      coverImageUrl: item.imageUrl ?? '',
      durationSeconds: item.durationSeconds ?? 0,
      categoryId: item.categoryIds.isNotEmpty ? item.categoryIds.first : '',
      moodTags: item.tags,
      videoType: type,
      aspectRatio: type == VideoType.shortForm ? 9 / 16 : 16 / 9,
      isFeatured: item.isFeatured,
      isPremium: item.isPremium,
      isActive: true,
      sortOrder: 0,
      createdAt: item.createdAt,
      updatedAt: item.createdAt,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// QUOTES SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _QuotesSection extends StatelessWidget {
  final List<ExploreItemEntity> items;
  final VoidCallback? onSeeAll;

  const _QuotesSection({required this.items, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Inspiring Quotes',
          subtitle: 'Words of wisdom',
          icon: Icons.format_quote_rounded,
          iconColor: const Color(0xFF0D9488),
          onSeeAll: onSeeAll,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 145.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final item = items[index];
              final quote = _toQuoteEntity(item);
              return QuoteCardWidget(
                quote: quote,
                onTap: () => _showQuoteDetail(context, item, items),
              );
            },
          ),
        ),
      ],
    );
  }

  QuoteEntity _toQuoteEntity(ExploreItemEntity item) {
    return QuoteEntity(
      id: item.id,
      quoteText: item.title,
      author: item.subtitle ?? '',
      authorIconUrl: item.thumbnailUrl,
      categoryId: item.categoryIds.isNotEmpty ? item.categoryIds.first : '',
      preferenceIds: item.tags,
      isFeatured: item.isFeatured,
      isPremium: item.isPremium,
      quoteType: 'quote',
      createdAt: item.createdAt,
      updatedAt: item.createdAt,
    );
  }

  void _showQuoteDetail(BuildContext context, ExploreItemEntity item, List<ExploreItemEntity> allItems) {
    final quotes = allItems.map((e) => _toQuoteEntity(e)).toList();
    final initialIndex = allItems.indexOf(item);

    context.pushNamed(
      RouteNames.contentViewer,
      extra: {
        'quotes': quotes,
        'initialIndex': initialIndex >= 0 ? initialIndex : 0,
        'title': 'Daily Inspiration',
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TIPS SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _TipsSection extends StatelessWidget {
  final List<ExploreItemEntity> items;
  final VoidCallback? onSeeAll;

  const _TipsSection({required this.items, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Wellness Tips',
          subtitle: 'Quick advice for daily wellness',
          icon: Icons.lightbulb_outline_rounded,
          iconColor: const Color(0xFFF59E0B),
          onSeeAll: onSeeAll,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 280.h,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final tip = _toTipEntity(item, index);
              return SizedBox(
                width: 260.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: TipCardWidget(
                    tip: tip,
                    onTap: () => _showTipDetail(context, item, items),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  static const _tipTypes = [
    TipType.relationshipBooster, // warm red  #FF6B6B
    TipType.communication,       // yellow    #FFE66D
    TipType.lettingGo,           // teal      #4ECDC4
    TipType.selfCare,            // mint      #95E1D3
    TipType.mindfulness,         // sage      #A8E6CF
    TipType.general,             // primary
  ];

  TipEntity _toTipEntity(ExploreItemEntity item, int index) {
    return TipEntity(
      id: item.id,
      title: item.title,
      tipText: item.description ?? '',
      author: item.subtitle ?? '',
      authorIconUrl: item.thumbnailUrl ?? '',
      categoryId: item.categoryIds.isNotEmpty ? item.categoryIds.first : '',
      preferenceIds: item.tags,
      tipType: _tipTypes[index % _tipTypes.length],
      isFeatured: item.isFeatured,
      isPremium: item.isPremium,
      sortOrder: 0,
      metadata: '',
      createdAt: item.createdAt,
      updatedAt: item.createdAt,
    );
  }

  void _showTipDetail(BuildContext context, ExploreItemEntity item, List<ExploreItemEntity> allItems) {
    final tips = [for (var i = 0; i < allItems.length; i++) _toTipEntity(allItems[i], i)];
    final initialIndex = allItems.indexOf(item);
    
    context.pushNamed(
      RouteNames.contentViewer,
      extra: {
        'tips': tips,
        'initialIndex': initialIndex >= 0 ? initialIndex : 0,
        'title': 'Wellness Tips',
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// IMAGES SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _ImagesSection extends StatelessWidget {
  final List<ExploreItemEntity> items;
  final VoidCallback? onSeeAll;

  const _ImagesSection({required this.items, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Calming Images',
          subtitle: 'Visual peace for your mind',
          icon: Icons.image_rounded,
          iconColor: const Color(0xFF10B981),
          onSeeAll: onSeeAll,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 280.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return ExploreImageCard(
                item: item,
                onTap: () {
                  final images = items.map((e) => ImageEntity(
                    id: e.id,
                    title: e.title,
                    description: e.description ?? '',
                    imageUrl: e.imageUrl ?? '',
                    thumbnailUrl: e.thumbnailUrl ?? '',
                    imageType: ImageType.motivation, // Defaulting or mapping
                    isFeatured: e.isFeatured,
                    isPremium: e.isPremium,
                    createdAt: e.createdAt,
                    updatedAt: e.createdAt,
                  )).toList();
                  
                  context.pushNamed(
                    RouteNames.imageViewer,
                    extra: {
                      'images': images,
                      'initialIndex': index,
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showImageDetail(BuildContext context, ExploreItemEntity item, List<ExploreItemEntity> allItems) {
    final images = allItems.map((e) => ImageEntity(
      id: e.id,
      title: e.title,
      description: e.description ?? '',
      imageUrl: e.imageUrl ?? '',
      thumbnailUrl: e.thumbnailUrl ?? '',
      imageType: ImageType.nature, // Mapping
      isFeatured: e.isFeatured,
      isPremium: e.isPremium,
      createdAt: e.createdAt,
      updatedAt: e.createdAt,
    )).toList();
    
    final initialIndex = allItems.indexOf(item);

    context.pushNamed(
      RouteNames.imageViewer,
      extra: {
        'images': images,
        'initialIndex': initialIndex >= 0 ? initialIndex : 0,
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LONG VIDEOS SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _LongVideosSection extends StatelessWidget {
  final List<ExploreItemEntity> items;
  final VoidCallback? onSeeAll;

  const _LongVideosSection({required this.items, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Featured Videos',
          subtitle: 'In-depth wellness content',
          icon: Icons.ondemand_video_rounded,
          iconColor: const Color(0xFF8B5CF6),
          onSeeAll: onSeeAll,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 250.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final item = items[index];
              final video = _toVideoEntity(item, VideoType.longForm);
              return SizedBox(
                width: 320.w,
                child: LongVideoCardWidget(
                  video: video,
                  onTap: () {
                    context.pushNamed(RouteNames.longVideoPlayer, extra: video);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  VideoEntity _toVideoEntity(ExploreItemEntity item, VideoType type) {
    return VideoEntity(
      id: item.id,
      title: item.title,
      description: item.description ?? '',
      artistName: item.subtitle ?? '',
      videoUrl: item.metadata?['videoUrl'] ?? '',
      thumbnailUrl: item.thumbnailUrl ?? '',
      coverImageUrl: item.imageUrl ?? '',
      durationSeconds: item.durationSeconds ?? 0,
      categoryId: item.categoryIds.isNotEmpty ? item.categoryIds.first : '',
      moodTags: item.tags,
      videoType: type,
      aspectRatio: 16 / 9,
      isFeatured: item.isFeatured,
      isPremium: item.isPremium,
      isActive: true,
      sortOrder: 0,
      createdAt: item.createdAt,
      updatedAt: item.createdAt,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CATEGORIES SECTION
// ─────────────────────────────────────────────────────────────────────────────

class _CategoriesSection extends StatelessWidget {
  final List<ExploreItemEntity> items;
  final VoidCallback? onSeeAll;

  const _CategoriesSection({required this.items, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Categories',
          subtitle: 'Browse by topic',
          icon: Icons.category_rounded,
          iconColor: const Color(0xFF3B82F6),
          onSeeAll: onSeeAll,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 160.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return CategoryCardWidget(
                category: _toCategoryEntity(item),
                onTap: () {
                  context.pushNamed(
                    RouteNames.categoryDetail,
                    extra: CategoryCardEntity(
                      id: item.id,
                      name: item.title,
                      imageUrl: item.imageUrl ?? '',
                      description: item.description ?? '',
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  CategoryEntity _toCategoryEntity(ExploreItemEntity item) {
    return CategoryEntity(
      id: item.id,
      name: item.title,
      imageUrl: item.imageUrl ?? '',
      description: item.description ?? '',
      preferenceIds: item.tags,
      createdAt: item.createdAt,
      updatedAt: item.createdAt,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PREVIEW CARDS
// ─────────────────────────────────────────────────────────────────────────────
