import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../audio/domain/entities/audio_entity.dart';
import '../../../dashboard/presentation/widgets/audio_card_widget.dart';
import '../../../dashboard/presentation/widgets/short_video_card_widget.dart';
import '../../../dashboard/presentation/widgets/long_video_card_widget.dart';
import '../../domain/entities/explore_item_entity.dart';
import '../bloc/explore_bloc.dart';
import '../widgets/explore_search_bar.dart';
import '../widgets/explore_filter_sheet.dart';
import '../widgets/explore_quote_card.dart';
import '../widgets/explore_tip_card.dart';
import '../widgets/explore_image_card.dart';
import '../widgets/explore_category_card.dart';
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: context.primaryColor),
          SizedBox(height: 16.h),
          Text(
            'Loading content...',
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

    return Column(
      children: [
        // Header with search
        _buildHeader(context, state),

        // Content
        Expanded(
          child: _showSuggestions && !state.isSearchActive
              ? _buildSuggestions(context, state)
              : state.hasResults
              ? _buildSectionedContent(context, state, itemsByType)
              : _buildEmptyState(context, state.isSearchActive),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, ExploreLoaded state) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
      decoration: BoxDecoration(
        color: context.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: context.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Discover content that inspires you',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: context.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Search bar
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

          // Quick type filters
          SizedBox(height: 16.h),
          _buildQuickFilters(context, state),
        ],
      ),
    );
  }

  Widget _buildQuickFilters(BuildContext context, ExploreLoaded state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
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
        ),
      ),
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
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: (iconColor ?? context.primaryColor).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: iconColor ?? context.primaryColor,
              ),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: context.textPrimaryColor,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onSeeAll != null) _SeeAllButton(onTap: onSeeAll!),
        ],
      ),
    );
  }
}

class _SeeAllButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SeeAllButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.primaryColor.withOpacity(0.08),
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'See All',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: context.primaryColor,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16.sp,
                color: context.primaryColor,
              ),
            ],
          ),
        ),
      ),
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
        SizedBox(
          height: 280.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return _ExploreAudioCard(
                item: item,
                onTap: () => _navigateToAudio(context, item),
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToAudio(BuildContext context, ExploreItemEntity item) {
    final audioEntity = AudioEntity(
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
    context.pushNamed(RouteNames.mediaPlayer, extra: audioEntity);
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
        SizedBox(
          height: 250.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return _ExploreShortVideoCard(
                item: item,
                onTap: () {
                  context.pushNamed(
                    RouteNames.shortsPlayer,
                    extra: items,
                    queryParameters: {'index': index.toString()},
                  );
                },
              );
            },
          ),
        ),
      ],
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
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return ExploreQuoteCard(
                item: item,
                gradientIndex: index,
                onTap: () => _showQuoteDetail(context, item),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showQuoteDetail(BuildContext context, ExploreItemEntity item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _QuoteDetailSheet(item: item),
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
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return ExploreTipCard(
                item: item,
                onTap: () => _showTipDetail(context, item),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showTipDetail(BuildContext context, ExploreItemEntity item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _TipDetailSheet(item: item),
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
        SizedBox(
          height: 200.h,
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
                onTap: () => _showImageDetail(context, item),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showImageDetail(BuildContext context, ExploreItemEntity item) {
    showDialog(
      context: context,
      builder: (_) => _ImageDetailDialog(item: item),
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
        SizedBox(
          height: 280.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final item = items[index];
              return SizedBox(
                width: 320.w,
                child: _ExploreLongVideoCard(
                  item: item,
                  onTap: () {
                    context.pushNamed(RouteNames.longVideoPlayer, extra: item.metadata);
                  },
                ),
              );
            },
          ),
        ),
      ],
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
              return ExploreCategoryCard(
                item: item,
                onTap: () {
                  context.pushNamed(RouteNames.preferences, extra: item.id);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ITEM CARDS
// ─────────────────────────────────────────────────────────────────────────────

class _ExploreAudioCard extends StatelessWidget {
  final ExploreItemEntity item;
  final VoidCallback? onTap;

  const _ExploreAudioCard({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180.w,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: context.borderColor.withOpacity(0.3),
            width: 1.5.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                        ? Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _buildPlaceholder(context),
                    )
                        : _buildPlaceholder(context),
                  ),
                  // Play button overlay
                  Positioned(
                    right: 8.w,
                    bottom: 8.h,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF6366F1),
                            const Color(0xFF6366F1).withOpacity(0.8),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6366F1).withOpacity(0.4),
                            blurRadius: 8.r,
                            offset: Offset(0, 2.h),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                  // Premium badge
                  if (item.isPremium)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star_rounded, size: 12.sp, color: Colors.white),
                            SizedBox(width: 2.w),
                            Text(
                              'PRO',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Track info
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.subtitle ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: context.textSecondaryColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  if (item.formattedDuration != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 14.sp,
                            color: const Color(0xFF6366F1),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            item.formattedDuration!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6366F1),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      color: const Color(0xFF6366F1).withOpacity(0.1),
      child: Icon(
        Icons.music_note_rounded,
        size: 60.sp,
        color: const Color(0xFF6366F1),
      ),
    );
  }
}

class _ExploreShortVideoCard extends StatelessWidget {
  final ExploreItemEntity item;
  final VoidCallback? onTap;

  const _ExploreShortVideoCard({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              // Thumbnail
              AspectRatio(
                aspectRatio: 9 / 16,
                child: item.thumbnailUrl != null && item.thumbnailUrl!.isNotEmpty
                    ? Image.network(
                  item.thumbnailUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildPlaceholder(context),
                )
                    : _buildPlaceholder(context),
              ),

              // Gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: const [0.5, 1.0],
                    ),
                  ),
                ),
              ),

              // Play button
              Center(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 2.w,
                    ),
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 32.sp,
                  ),
                ),
              ),

              // Duration badge
              if (item.formattedDuration != null)
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      item.formattedDuration!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              // Title at bottom
              Positioned(
                left: 8.w,
                right: 8.w,
                bottom: 32.h,
                child: Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4.r,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFEC4899).withOpacity(0.6),
            const Color(0xFFEC4899).withOpacity(0.3),
          ],
        ),
      ),
      child: Icon(
        Icons.video_library_rounded,
        size: 50.sp,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
}

class _ExploreLongVideoCard extends StatelessWidget {
  final ExploreItemEntity item;
  final VoidCallback? onTap;

  const _ExploreLongVideoCard({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: context.surfaceColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail (16:9)
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                      Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(context),
                      )
                    else
                      _buildPlaceholder(context),

                    // Play button overlay
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6).withOpacity(0.8),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF8B5CF6).withOpacity(0.4),
                                blurRadius: 12.r,
                                offset: Offset(0, 4.h),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 36.sp,
                          ),
                        ),
                      ),
                    ),

                    // Duration badge
                    if (item.formattedDuration != null)
                      Positioned(
                        bottom: 8.h,
                        right: 8.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            item.formattedDuration!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Info section
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Artist avatar
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: const Color(0xFF8B5CF6).withOpacity(0.2),
                    child: Text(
                      item.subtitle?.isNotEmpty == true
                          ? item.subtitle![0].toUpperCase()
                          : '?',
                      style: TextStyle(
                        color: const Color(0xFF8B5CF6),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Title and metadata
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          item.subtitle ?? '',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            color: context.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8B5CF6).withOpacity(0.3),
            const Color(0xFF8B5CF6).withOpacity(0.1),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.play_circle_outline_rounded,
          size: 60.sp,
          color: const Color(0xFF8B5CF6).withOpacity(0.5),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DETAIL SHEETS (No BLoC dependency)
// ─────────────────────────────────────────────────────────────────────────────

class _QuoteDetailSheet extends StatelessWidget {
  final ExploreItemEntity item;

  const _QuoteDetailSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0D9488), Color(0xFF0F766E)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 32.h),
          Icon(
            Icons.format_quote_rounded,
            size: 40.sp,
            color: Colors.white.withOpacity(0.4),
          ),
          SizedBox(height: 16.h),
          Text(
            item.title,
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              color: Colors.white,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          if (item.subtitle != null) ...[
            Container(
              width: 40.w,
              height: 2.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(1.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              '— ${item.subtitle}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
          SizedBox(height: 32.h + MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

class _TipDetailSheet extends StatelessWidget {
  final ExploreItemEntity item;

  const _TipDetailSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          if (item.tags.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                item.tags.first,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          SizedBox(height: 16.h),
          Text(
            item.title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          if (item.description != null)
            Text(
              item.description!,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
              ),
            ),
          SizedBox(height: 24.h),
          if (item.subtitle != null)
            Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: Text(
                    item.subtitle![0].toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  item.subtitle!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          SizedBox(height: 16.h + MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

class _ImageDetailDialog extends StatelessWidget {
  final ExploreItemEntity item;

  const _ImageDetailDialog({required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.network(
              item.imageUrl ?? '',
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                height: 300.h,
                color: context.surfaceColor,
                child: Icon(
                  Icons.image_not_supported_rounded,
                  size: 48.sp,
                  color: context.textSecondaryColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                if (item.subtitle != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    item.subtitle!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.sp,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}