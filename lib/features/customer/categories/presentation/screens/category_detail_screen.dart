import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/premium_tag_widget.dart';
import '../../../audio/domain/entities/audio_entity.dart';
import '../../../dashboard/domain/entities/quote_entity.dart';
import '../../../dashboard/presentation/widgets/audio_card_widget.dart';
import '../../../dashboard/presentation/widgets/long_video_card_widget.dart';
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
  /// When set and category.id is empty, loads only this content type.
  final ExploreItemType? contentType;

  const CategoryDetailScreen({
    super.key,
    required this.category,
    this.contentType,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ExploreItemEntity> _filtered(List<ExploreItemEntity> items) {
    return items.where((item) {
      if (item.type == ExploreItemType.category) return false;
      if (_searchQuery.isEmpty) return true;
      return item.title.toLowerCase().contains(_searchQuery) ||
          (item.subtitle?.toLowerCase().contains(_searchQuery) ?? false) ||
          item.tags.any((t) => t.toLowerCase().contains(_searchQuery));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) {
        final bloc = getIt<ExploreBloc>();
        if (widget.category.id.isNotEmpty) {
          bloc.add(LoadExploreItemsForCategory(widget.category.id));
        } else if (widget.contentType != null) {
          bloc.add(LoadExploreItemsByType(widget.contentType!));
        } else {
          bloc.add(const LoadExploreItems());
        }
        return bloc;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: BlocBuilder<ExploreBloc, ExploreState>(
          builder: (context, state) {
            List<ExploreItemEntity> items = [];
            if (state is ExploreLoaded) {
              items = state.allItems;
            }

            final filtered = _filtered(items);
            final isLoading = state is ExploreLoading || state is ExploreInitial;

            List<dynamic> groupedItems = [];
            for (int i = 0; i < filtered.length; i++) {
              final item = filtered[i];
              if (item.type == ExploreItemType.shortVideo || item.type == ExploreItemType.image) {
                if (groupedItems.isNotEmpty && groupedItems.last is List<ExploreItemEntity>) {
                   List<ExploreItemEntity> group = groupedItems.last;
                   if (group.length == 1 && group.first.type == item.type) {
                     group.add(item);
                   } else {
                     groupedItems.add([item]);
                   }
                } else {
                  groupedItems.add([item]);
                }
              } else {
                groupedItems.add(item);
              }
            }

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
                  expandedHeight: 120.h,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 12.h),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 20.sp,
                                      color: context.textPrimaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                                  child: Text(
                                    widget.category.name,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: context.textPrimaryColor,
                                    ),
                                    textAlign: TextAlign.center,
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
                          final itemOrGroup = groupedItems[index];

                          if (itemOrGroup is List<ExploreItemEntity>) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: itemOrGroup[0].type == ExploreItemType.shortVideo 
                                        ? _buildShortVideoWithGridStyle(itemOrGroup[0], filtered)
                                        : _buildImageWithGridStyle(itemOrGroup[0], filtered),
                                  ),
                                  SizedBox(width: 12.w),
                                  if (itemOrGroup.length > 1)
                                    Expanded(
                                      child: itemOrGroup[1].type == ExploreItemType.shortVideo
                                          ? _buildShortVideoWithGridStyle(itemOrGroup[1], filtered)
                                          : _buildImageWithGridStyle(itemOrGroup[1], filtered),
                                    )
                                  else
                                    Expanded(child: const SizedBox()),
                                ],
                              ),
                            );
                          }

                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: _buildCard(itemOrGroup as ExploreItemEntity, filtered.indexOf(itemOrGroup), filtered),
                          );
                        },
                        childCount: groupedItems.length,
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
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2C2C2E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDarkMode
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(Icons.search_rounded,
              size: 22.sp, color: context.textSecondaryColor),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (v) =>
                  setState(() => _searchQuery = v.toLowerCase()),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15.sp,
                color: context.textPrimaryColor,
              ),
              decoration: InputDecoration(
                hintText: 'Search ${widget.category.name}...',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: context.textSecondaryColor.withOpacity(0.6),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() => _searchQuery = '');
              },
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close_rounded,
                    size: 14.sp, color: context.textSecondaryColor),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildShortVideoWithGridStyle(ExploreItemEntity item, List<ExploreItemEntity> all) {
    final shorts = all.where((e) => e.type == ExploreItemType.shortVideo).map(_toVideo).toList();
    final shortIdx = shorts.indexWhere((v) => v.id == item.id);
    return ShortVideoCardWidget(
      video: _toVideo(item),
      width: double.infinity,
      containerWidth: double.infinity,
      margin: EdgeInsets.zero,
      onTap: () => context.pushNamed(
        RouteNames.shortsPlayer,
        extra: shorts, 
        queryParameters: {'index': '${shortIdx < 0 ? 0 : shortIdx}'}
      ),
    );
  }

  Widget _buildCard(ExploreItemEntity item, int index, List<ExploreItemEntity> all) {
    switch (item.type) {
      case ExploreItemType.audio:
        return AudioCardWidget(
          track: _toAudio(item),
          onTap: () => context.pushNamed(RouteNames.mediaPlayer, extra: _toAudio(item)),
        );
      case ExploreItemType.shortVideo:
        final shorts = all.where((e) => e.type == ExploreItemType.shortVideo).map(_toVideo).toList();
        final shortIdx = shorts.indexWhere((v) => v.id == item.id);
        return ShortVideoCardWidget(
          video: _toVideo(item),
          onTap: () => context.pushNamed(RouteNames.shortsPlayer,
              extra: shorts, queryParameters: {'index': '${shortIdx < 0 ? 0 : shortIdx}'}),
        );
      case ExploreItemType.longVideo:
        return LongVideoCardWidget(
          video: _toVideo(item),
          onTap: () => context.pushNamed(RouteNames.longVideoPlayer, extra: _toVideo(item)),
        );
      case ExploreItemType.quote:
        final quotes = all.where((e) => e.type == ExploreItemType.quote).map(_toQuote).toList();
        final quoteIdx = quotes.indexWhere((q) => q.id == item.id);
        return GestureDetector(
          onTap: () => context.pushNamed(RouteNames.contentViewer, extra: {
            'quotes': quotes,
            'initialIndex': quoteIdx < 0 ? 0 : quoteIdx,
            'title': widget.category.name,
          }),
          child: _buildQuoteListItem(_toQuote(item)),
        );
      case ExploreItemType.tip:
        final tips = all.where((e) => e.type == ExploreItemType.tip).map(_toTip).toList();
        final tipIdx = tips.indexWhere((t) => t.id == item.id);
        return TipCardWidget(
          tip: _toTip(item),
          onTap: () => context.pushNamed(RouteNames.contentViewer, extra: {
            'tips': tips,
            'initialIndex': tipIdx < 0 ? 0 : tipIdx,
            'title': widget.category.name,
          }),
        );
      case ExploreItemType.image:
        return _buildImageItem(item, all);
      case ExploreItemType.category:
        return const SizedBox.shrink();
    }
  }

  Widget _buildImageItem(ExploreItemEntity item, List<ExploreItemEntity> all, {bool isGrid = false}) {
    final images = all.where((e) => e.type == ExploreItemType.image).toList();
    final imgIdx = images.indexWhere((i) => i.id == item.id);
    return GestureDetector(
      onTap: () => context.pushNamed(RouteNames.imageViewer, extra: {
        'images': images, // passing full ExploreItemEntity to preserve isPremium
        'titles': images.map((e) => e.title).toList(),
        'subtitles': images.map((e) => e.subtitle ?? '').toList(),
        'initialIndex': imgIdx < 0 ? 0 : imgIdx,
        'categoryName': widget.category.name,
      }),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: AspectRatio(
          aspectRatio: isGrid ? 3 / 4 : 16 / 9,
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

              PremiumTagWidget(
                isPremium: item.isPremium,
                top: 8,
                left: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithGridStyle(ExploreItemEntity item, List<ExploreItemEntity> all) {
    return _buildImageItem(item, all, isGrid: true);
  }

  Widget _buildQuoteListItem(QuoteEntity quote) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xFF1E1E2C).withOpacity(0.85)
                : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.08)
                  : Colors.black.withOpacity(0.06),
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.06),
                blurRadius: 12.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.format_quote_rounded,
                size: 24.sp,
                color: context.primaryColor.withOpacity(0.5),
              ),
              SizedBox(height: 8.h),
              Text(
                '"${quote.quoteText}"',
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimaryColor,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  if (quote.authorIconUrl?.isNotEmpty ?? false) ...[
                    CircleAvatar(
                      radius: 10.r,
                      backgroundColor: context.primaryColor.withOpacity(0.1),
                      child: ClipOval(
                        child: Image.network(
                          quote.authorIconUrl!,
                          width: 20.r,
                          height: 20.r,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.person_rounded,
                            size: 12.sp,
                            color: context.primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                  ],
                  Expanded(
                    child: Text(
                      '— ${quote.author}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        color: context.textSecondaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
        authorIconUrl: e.imageUrl,
        categoryId: e.categoryIds.firstOrNull,
        preferenceIds: const [],
        isFeatured: e.isFeatured,
        isPremium: e.isPremium,
        quoteType: 'quote',
        createdAt: e.createdAt,
        updatedAt: e.createdAt,
      );

  TipType _parseTipType(ExploreItemEntity e) {
    String typeStr = e.metadata?['tipType']?.toString() ?? '';
    if (typeStr.isEmpty && e.tags.isNotEmpty) {
      typeStr = e.tags.first;
    }
    
    if (typeStr == TipType.relationshipBooster.toString()) return TipType.relationshipBooster;
    if (typeStr == TipType.lettingGo.toString()) return TipType.lettingGo;
    if (typeStr == TipType.communication.toString()) return TipType.communication;
    if (typeStr == TipType.selfCare.toString()) return TipType.selfCare;
    if (typeStr == TipType.mindfulness.toString()) return TipType.mindfulness;
    if (typeStr == TipType.general.toString()) return TipType.general;

    final lower = typeStr.toLowerCase();
    if (lower.contains('relationship')) return TipType.relationshipBooster;
    if (lower.contains('letting')) return TipType.lettingGo;
    if (lower.contains('communication')) return TipType.communication;
    if (lower.contains('self_care') || lower.contains('self-care') || lower.contains('self care')) return TipType.selfCare;
    if (lower.contains('mindful')) return TipType.mindfulness;
    
    return TipType.general;
  }

  TipEntity _toTip(ExploreItemEntity e) => TipEntity(
        id: e.id,
        title: e.title,
        tipText: e.description ?? e.subtitle ?? '',
        author: e.subtitle ?? '',
        authorIconUrl: e.metadata?['authorIconUrl'] as String? ?? '',
        categoryId: e.categoryIds.firstOrNull ?? '',
        preferenceIds: const [],
        tipType: _parseTipType(e),
        isFeatured: e.isFeatured,
        isPremium: e.isPremium,
        sortOrder: 0,
        metadata: '',
        createdAt: e.createdAt,
        updatedAt: e.createdAt,
      );
}
