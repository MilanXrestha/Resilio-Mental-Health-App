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
    final baseColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor =
        isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mirrors [_buildHeader]: Explore title + subtitle + search bar
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160.w,
                    height: 34.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 260.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    width: double.infinity,
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ],
              ),
            ),

            ...List.generate(
              3,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildShimmerSection(context),
                  if (index < 2) SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section header + horizontal cards (aligned with [_CategoryContentSection]).
  Widget _buildShimmerSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 180.w,
                    height: 22.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    width: 120.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
              Container(
                width: 72.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 248.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (_, _) => SizedBox(width: 24.w),
            itemBuilder: (_, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 160.w,
                  height: 168.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  width: 140.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 96.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
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
    final categories = itemsByType[ExploreItemType.category] ?? [];
    final Map<String, List<ExploreItemEntity>> itemsByCategory = {};
    final List<ExploreItemEntity> uncategorized = [];

    for (final item in state.filteredItems) {
      if (item.type == ExploreItemType.category) continue;
      if (item.categoryIds.isEmpty) {
        uncategorized.add(item);
      } else {
        for (final catId in item.categoryIds) {
          itemsByCategory.putIfAbsent(catId, () => []).add(item);
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...categories.expand((category) {
          final items = itemsByCategory[category.id] ?? [];
          if (items.isEmpty) return <Widget>[];
          return <Widget>[
            _CategoryContentSection(
              categoryTitle: category.title,
              items: items,
              allItems: state.allItems,
              onSeeAll: () {
                context.pushNamed(
                  RouteNames.categoryDetail,
                  extra: CategoryCardEntity(
                    id: category.id,
                    name: category.title,
                    imageUrl: category.imageUrl ?? '',
                    description: category.description ?? '',
                  ),
                );
              },
            ),
            SizedBox(height: 32.h),
          ];
        }),
        if (uncategorized.isNotEmpty) ...[
          _CategoryContentSection(
            categoryTitle: 'Other Content',
            items: uncategorized,
            allItems: state.allItems,
          ),
          SizedBox(height: 32.h),
        ],
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
    context.read<ExploreBloc>().add(
      UpdateFilters(ExploreFilter(types: [type])),
    );
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
            color: isSelected
                ? chipColor
                : context.borderColor.withOpacity(0.3),
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
// CATEGORY CONTENT SECTION (MIXED)
// ─────────────────────────────────────────────────────────────────────────────

class _CategoryContentSection extends StatelessWidget {
  final String categoryTitle;
  final List<ExploreItemEntity> items;
  final List<ExploreItemEntity> allItems;
  final VoidCallback? onSeeAll;

  const _CategoryContentSection({
    required this.categoryTitle,
    required this.items,
    required this.allItems,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    double _getMaxHeight() {
      double maxHeight = 145.h; // default minimum
      for (final item in items) {
        double h = 0;
        switch (item.type) {
          case ExploreItemType.audio:
            h = 190.h;
            break;
          case ExploreItemType.shortVideo:
            h = 245.h;
            break;
          case ExploreItemType.longVideo:
            h = 300.h;
            break;
          case ExploreItemType.quote:
            h = 145.h;
            break;
          case ExploreItemType.tip:
            h = 280.h;
            break;
          case ExploreItemType.image:
            h = 280.h;
            break;
          case ExploreItemType.category:
            h = 160.h;
            break;
        }
        if (h > maxHeight) maxHeight = h;
      }
      return maxHeight;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: categoryTitle,
          subtitle: '',
          icon: Icons.category_rounded,
          iconColor: const Color(0xFF3B82F6),
          onSeeAll: onSeeAll,
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: _getMaxHeight(),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 24.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return Align(
                alignment: Alignment.topCenter,
                child: _buildCardForItem(context, item, index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCardForItem(
    BuildContext context,
    ExploreItemEntity item,
    int index,
  ) {
    switch (item.type) {
      case ExploreItemType.audio:
        final audio = _toAudioEntity(item);
        return SizedBox(
          height: 190.h,
          child: AudioCardWidget(
            track: audio,
            onTap: () =>
                context.pushNamed(RouteNames.mediaPlayer, extra: audio),
          ),
        );

      case ExploreItemType.shortVideo:
        return SizedBox(
          height: 245.h,
          child: ShortVideoCardWidget(
            video: _toVideoEntity(item, VideoType.shortForm),
            onTap: () {
              final videos = items
                  .where((i) => i.type == ExploreItemType.shortVideo)
                  .map((i) => _toVideoEntity(i, VideoType.shortForm))
                  .toList();
              context.pushNamed(RouteNames.shortsPlayer, extra: videos);
            },
          ),
        );

      case ExploreItemType.longVideo:
        final video = _toVideoEntity(item, VideoType.longForm);
        return SizedBox(
          height: 300.h,
          width: 320.w,
          child: LongVideoCardWidget(
            video: video,
            onTap: () =>
                context.pushNamed(RouteNames.longVideoPlayer, extra: video),
          ),
        );

      case ExploreItemType.quote:
        final quote = _toQuoteEntity(item);
        return SizedBox(
          height: 145.h,
          child: QuoteCardWidget(
            quote: quote,
            onTap: () => _showQuoteDetail(context, item),
          ),
        );

      case ExploreItemType.tip:
        final tip = _toTipEntity(item, index);
        return SizedBox(
          height: 280.h,
          width: 260.w,
          child: TipCardWidget(
            tip: tip,
            onTap: () => _showTipDetail(context, item),
          ),
        );

      case ExploreItemType.image:
        return SizedBox(
          height: 280.h,
          child: ExploreImageCard(
            item: item,
            onTap: () => _showImageDetail(context, item),
          ),
        );

      case ExploreItemType.category:
        return SizedBox(
          height: 160.h,
          child: CategoryCardWidget(
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
          ),
        );
    }
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

  void _showQuoteDetail(BuildContext context, ExploreItemEntity item) {
    final quotes = items
        .where((e) => e.type == ExploreItemType.quote)
        .map((e) => _toQuoteEntity(e))
        .toList();
    final localItem = _toQuoteEntity(item);
    final initialIndex = quotes.indexWhere((q) => q.id == localItem.id);

    context.pushNamed(
      RouteNames.contentViewer,
      extra: {
        'quotes': quotes,
        'initialIndex': initialIndex >= 0 ? initialIndex : 0,
        'title': categoryTitle,
      },
    );
  }

  static const _tipTypes = [
    TipType.relationshipBooster,
    TipType.communication,
    TipType.lettingGo,
    TipType.selfCare,
    TipType.mindfulness,
    TipType.general,
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

  void _showTipDetail(BuildContext context, ExploreItemEntity item) {
    final tipItems = items.where((e) => e.type == ExploreItemType.tip).toList();
    final tips = [
      for (var i = 0; i < tipItems.length; i++) _toTipEntity(tipItems[i], i),
    ];
    final initialIndex = tipItems.indexOf(item);

    context.pushNamed(
      RouteNames.contentViewer,
      extra: {
        'tips': tips,
        'initialIndex': initialIndex >= 0 ? initialIndex : 0,
        'title': categoryTitle,
      },
    );
  }

  void _showImageDetail(BuildContext context, ExploreItemEntity item) {
    final imageItems = items
        .where((e) => e.type == ExploreItemType.image)
        .toList();
    final images = imageItems
        .map(
          (e) => ImageEntity(
            id: e.id,
            title: e.title,
            description: e.description ?? '',
            imageUrl: e.imageUrl ?? '',
            thumbnailUrl: e.thumbnailUrl ?? '',
            imageType: ImageType.nature,
            isFeatured: e.isFeatured,
            isPremium: e.isPremium,
            createdAt: e.createdAt,
            updatedAt: e.createdAt,
          ),
        )
        .toList();

    final initialIndex = imageItems.indexOf(item);

    context.pushNamed(
      RouteNames.imageViewer,
      extra: {
        'images': images,
        'initialIndex': initialIndex >= 0 ? initialIndex : 0,
      },
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
