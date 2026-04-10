import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../audio/domain/entities/audio_entity.dart';
import '../../../dashboard/domain/entities/quote_entity.dart';
import '../../../dashboard/presentation/widgets/audio_card_widget.dart';
import '../../../dashboard/presentation/widgets/long_video_card_widget.dart';
import '../../../dashboard/presentation/widgets/quote_card_widget.dart';
import '../../../dashboard/presentation/widgets/short_video_card_widget.dart';
import '../../../explore/domain/entities/explore_item_entity.dart';
import '../../../explore/presentation/bloc/explore_bloc.dart';
import '../../../tips/domain/entities/tip_entity.dart';
import '../../../tips/presentation/widgets/tip_card_widget.dart';
import '../../../video/domain/entities/video_entity.dart';

import '../../domain/entities/category_card_entity.dart';

/// Full-page category detail screen — shown when user taps "See All" on a category.
class CategoryDetailScreen extends StatefulWidget {
  final CategoryCardEntity category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  ExploreItemType? _selectedType;
  String _searchQuery = '';

  final Map<ExploreItemType?, String> _typeLabels = {
    null: 'All',
    ExploreItemType.audio: 'Audio',
    ExploreItemType.shortVideo: 'Shorts',
    ExploreItemType.longVideo: 'Videos',
    ExploreItemType.quote: 'Quotes',
    ExploreItemType.tip: 'Tips',
    ExploreItemType.image: 'Images',
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ExploreItemEntity> _filtered(List<ExploreItemEntity> items) {
    return items.where((item) {
      if (item.type == ExploreItemType.category) return false;
      final matchesType = _selectedType == null || item.type == _selectedType;
      final matchesSearch = _searchQuery.isEmpty ||
          item.title.toLowerCase().contains(_searchQuery) ||
          (item.subtitle?.toLowerCase().contains(_searchQuery) ?? false) ||
          item.tags.any((t) => t.toLowerCase().contains(_searchQuery));
      return matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => getIt<ExploreBloc>()..add(const LoadExploreItems()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            List<ExploreItemEntity> items = [];
            if (state is ExploreLoaded) {
              items = state.allItems.where((item) =>
                item.categoryIds.isEmpty ||
                item.categoryIds.contains(widget.category.id),
              ).toList();
            }

            final filtered = _filtered(items);
            final isLoading = state is ExploreLoading;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── SliverAppBar ─────────────────────────────────────
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  snap: false,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  expandedHeight: 110.h,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 20.sp,
                                    color: context.textPrimaryColor,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    widget.category.name,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: context.textPrimaryColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: _buildSearchField(isDarkMode),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Type filter chips ─────────────────────────────────
                SliverToBoxAdapter(
                  child: _buildFilterChips(isDarkMode),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 8.h)),

                // ── Content ───────────────────────────────────────────
                if (isLoading)
                  SliverToBoxAdapter(child: _buildShimmer())
                else if (filtered.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off_rounded,
                              size: 64.sp,
                              color: context.textSecondaryColor),
                          SizedBox(height: 12.h),
                          Text(
                            'No content found',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.sp,
                              color: context.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 100.h),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: _buildCard(filtered[index]),
                          );
                        },
                        childCount: filtered.length,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchField(bool isDarkMode) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.white.withOpacity(0.07)
                : Colors.white.withOpacity(0.92),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.08),
              width: 1.2.w,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Icon(Icons.search_rounded,
                    size: 20.sp, color: context.textSecondaryColor),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) =>
                      setState(() => _searchQuery = v.toLowerCase()),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    color: context.textPrimaryColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search ${widget.category.name}...',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: context.textSecondaryColor.withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
              if (_searchQuery.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Icon(Icons.close_rounded,
                        size: 18.sp, color: context.textSecondaryColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips(bool isDarkMode) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: _typeLabels.entries.map((entry) {
          final isSelected = _selectedType == entry.key;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => setState(() => _selectedType = entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.primaryColor
                      : (isDarkMode
                          ? Colors.white.withOpacity(0.08)
                          : Colors.black.withOpacity(0.06)),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  entry.value,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : context.textSecondaryColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCard(ExploreItemEntity item) {
    switch (item.type) {
      case ExploreItemType.audio:
        return AudioCardWidget(track: _toAudio(item), onTap: () {});
      case ExploreItemType.shortVideo:
        return ShortVideoCardWidget(video: _toVideo(item), onTap: () {});
      case ExploreItemType.longVideo:
        return LongVideoCardWidget(video: _toVideo(item), onTap: () {});
      case ExploreItemType.quote:
        return QuoteCardWidget(quote: _toQuote(item), onTap: () {});
      case ExploreItemType.tip:
        return TipCardWidget(tip: _toTip(item), onTap: () {});
      case ExploreItemType.image:
        return _buildImageItem(item);
      case ExploreItemType.category:
        return const SizedBox.shrink();
    }
  }

  Widget _buildImageItem(ExploreItemEntity item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (item.imageUrl?.isNotEmpty ?? false)
              Image.network(item.imageUrl!, fit: BoxFit.cover)
            else
              Container(
                color: Colors.grey.shade800,
                child: Icon(Icons.image_not_supported_rounded,
                    size: 40.sp, color: Colors.white30),
              ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent
                    ],
                  ),
                ),
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Column(
      children: List.generate(
        4,
        (i) => Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
          child: Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }

  // ── Entity adapters ────────────────────────────────────────────────────
  AudioEntity _toAudio(ExploreItemEntity e) => AudioEntity(
        id: e.id,
        title: e.title,
        description: e.description ?? '',
        artistName: e.subtitle ?? '',
        audioUrl: e.metadata?['audioUrl'] as String? ?? '',
        coverImageUrl: e.imageUrl ?? '',
        thumbnailUrl: e.thumbnailUrl ?? e.imageUrl ?? '',
        durationSeconds: e.durationSeconds ?? 0,
        categoryId: e.categoryIds.firstOrNull ?? '',
        moodTags: e.tags,
        isFeatured: e.isFeatured,
        isPremium: e.isPremium,
        sortOrder: 0,
        createdAt: e.createdAt,
        updatedAt: e.createdAt,
      );

  VideoEntity _toVideo(ExploreItemEntity e) => VideoEntity(
        id: e.id,
        title: e.title,
        description: e.description ?? '',
        artistName: e.subtitle ?? '',
        videoUrl: e.metadata?['videoUrl'] as String? ?? '',
        thumbnailUrl: e.thumbnailUrl ?? e.imageUrl ?? '',
        coverImageUrl: e.imageUrl ?? '',
        durationSeconds: e.durationSeconds ?? 0,
        categoryId: e.categoryIds.firstOrNull ?? '',
        moodTags: e.tags,
        videoType: e.type == ExploreItemType.shortVideo
            ? VideoType.shortForm
            : VideoType.longForm,
        aspectRatio: e.type == ExploreItemType.shortVideo ? 9 / 16 : 16 / 9,
        isFeatured: e.isFeatured,
        isPremium: e.isPremium,
        isActive: true,
        sortOrder: 0,
        createdAt: e.createdAt,
        updatedAt: e.createdAt,
      );

  QuoteEntity _toQuote(ExploreItemEntity e) => QuoteEntity(
        id: e.id,
        quoteText: e.title,
        author: e.subtitle ?? '',
        authorIconUrl: e.metadata?['authorIconUrl'] as String?,
        categoryId: e.categoryIds.firstOrNull,
        preferenceIds: const [],
        isFeatured: e.isFeatured,
        isPremium: e.isPremium,
        quoteType: 'quote',
        createdAt: e.createdAt,
        updatedAt: e.createdAt,
      );

  TipEntity _toTip(ExploreItemEntity e) => TipEntity(
        id: e.id,
        title: e.title,
        tipText: e.description ?? e.subtitle ?? '',
        author: e.subtitle ?? '',
        authorIconUrl: e.metadata?['authorIconUrl'] as String? ?? '',
        categoryId: e.categoryIds.firstOrNull ?? '',
        preferenceIds: const [],
        tipType: TipType.general,
        isFeatured: e.isFeatured,
        isPremium: e.isPremium,
        sortOrder: 0,
        metadata: '',
        createdAt: e.createdAt,
        updatedAt: e.createdAt,
      );
}
