import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/routing/route_names.dart';
import '../../../../../core/theme/app_colors.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

import '../../../dashboard/domain/entities/quote_entity.dart';
import '../../../favorites/domain/entities/favorite_entity.dart';
import '../../../favorites/presentation/bloc/favorite_bloc.dart';
import '../../../favorites/presentation/bloc/favorite_event.dart';
import '../../../favorites/presentation/bloc/favorite_state.dart';

import '../../../explore/presentation/bloc/explore_bloc.dart';
import '../../../explore/domain/entities/explore_item_entity.dart';

import '../../../audio/domain/entities/audio_entity.dart';
import '../../../video/domain/entities/video_entity.dart';
import '../../../tips/domain/entities/tip_entity.dart';
import '../../../images/domain/entities/image_entity.dart';

import '../../../explore/presentation/widgets/explore_image_card.dart';
import '../../../dashboard/presentation/widgets/audio_card_widget.dart';
import '../../../dashboard/presentation/widgets/short_video_card_widget.dart';
import '../../../dashboard/presentation/widgets/long_video_card_widget.dart';
import '../../../dashboard/presentation/widgets/quote_card_widget.dart';
import '../../../tips/presentation/widgets/tip_card_widget.dart';

// ── Tab meta ──────────────────────────────────────────────────────────────────

class _TabMeta {
  final String label;
  final FavoriteType type;
  final IconData icon;
  final List<Color> gradient;
  const _TabMeta({
    required this.label,
    required this.type,
    required this.icon,
    required this.gradient,
  });
}

const _kTabs = [
  _TabMeta(
    label: 'Audio',
    type: FavoriteType.audio,
    icon: Icons.headphones_rounded,
    gradient: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
  ),
  _TabMeta(
    label: 'Videos',
    type: FavoriteType.video,
    icon: Icons.play_circle_filled_rounded,
    gradient: [Color(0xFFEF4444), Color(0xFFEC4899)],
  ),
  _TabMeta(
    label: 'Quotes',
    type: FavoriteType.quote,
    icon: Icons.format_quote_rounded,
    gradient: [Color(0xFFF59E0B), Color(0xFFEF4444)],
  ),
  _TabMeta(
    label: 'Tips',
    type: FavoriteType.tip,
    icon: Icons.lightbulb_rounded,
    gradient: [Color(0xFF10B981), Color(0xFF059669)],
  ),
  _TabMeta(
    label: 'Images',
    type: FavoriteType.image,
    icon: Icons.image_rounded,
    gradient: [Color(0xFF0EA5E9), Color(0xFF6366F1)],
  ),
];

// ── Root widget ───────────────────────────────────────────────────────────────

class FavoriteScreen extends StatelessWidget {
  final Function(bool) onSearchActiveChanged;

  const FavoriteScreen({super.key, required this.onSearchActiveChanged});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExploreBloc>()..add(const LoadExploreItems()),
      child: _FavoriteView(onSearchActiveChanged: onSearchActiveChanged),
    );
  }
}

// ── View ──────────────────────────────────────────────────────────────────────

class _FavoriteView extends StatefulWidget {
  final Function(bool) onSearchActiveChanged;
  const _FavoriteView({required this.onSearchActiveChanged});

  @override
  State<_FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<_FavoriteView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _kTabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) return;
      setState(() => _selectedIndex = _tabController.index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ExploreBloc>().add(const RefreshExploreItems());
      final auth = context.read<AuthBloc>().state;
      if (auth is AuthAuthenticated) {
        context.read<FavoriteBloc>().add(LoadFavorites(auth.user.id));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ── Counts helper ──────────────────────────────────────────────────────────

  Map<FavoriteType, int> _computeCounts(FavoritesLoaded state) {
    final counts = <FavoriteType, int>{};
    for (final tab in _kTabs) {
      if (tab.type == FavoriteType.video) {
        counts[tab.type] = state.favorites
            .where((f) =>
                f.contentType == FavoriteType.video ||
                f.contentType == FavoriteType.longVideo ||
                f.contentType == FavoriteType.shortVideo)
            .length;
      } else {
        counts[tab.type] =
            state.favorites.where((f) => f.contentType == tab.type).length;
      }
    }
    return counts;
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, next) =>
          prev is! AuthAuthenticated && next is AuthAuthenticated,
      listener: (context, authState) {
        if (authState is AuthAuthenticated) {
          context.read<FavoriteBloc>().add(LoadFavorites(authState.user.id));
          context.read<ExploreBloc>().add(const RefreshExploreItems());
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(selectedTabIndex: _selectedIndex),
            _TabPills(
              tabController: _tabController,
              selectedIndex: _selectedIndex,
              computeCounts: (state) => _computeCounts(state),
              onTabSelected: (i) {
                _tabController.animateTo(i);
                setState(() => _selectedIndex = i);
              },
            ),
            Expanded(child: _TabContent(tabController: _tabController)),
          ],
        ),
      ),
    );
  }
}

// ── Header ────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final int selectedTabIndex;
  const _Header({required this.selectedTabIndex});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        final total = state is FavoritesLoaded ? state.favorites.length : 0;
        final tab = _kTabs[selectedTabIndex];

        return Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 12.h,
            left: 20.w,
            right: 20.w,
            bottom: 20.h,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF12121F), const Color(0xFF1C1C35)]
                  : [const Color(0xFFF4F0FF), const Color(0xFFEBF4FF)],
            ),
          ),
          child: Row(
            children: [
              // ── Text column ────────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Favorites',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        color: context.textPrimaryColor,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        total == 0
                            ? 'Heart content to save it here'
                            : '$total saved item${total != 1 ? 's' : ''} across all categories',
                        key: ValueKey(total),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.sp,
                          color: context.textSecondaryColor.withOpacity(0.65),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              // ── Heart badge ────────────────────────────────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                padding: EdgeInsets.all(13.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: tab.gradient,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: tab.gradient.first.withOpacity(0.45),
                      blurRadius: 14.r,
                      offset: Offset(0, 5.h),
                    ),
                  ],
                ),
                child: Icon(
                  tab.icon,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Pill tab bar ──────────────────────────────────────────────────────────────

class _TabPills extends StatelessWidget {
  final TabController tabController;
  final int selectedIndex;
  final Map<FavoriteType, int> Function(FavoritesLoaded) computeCounts;
  final void Function(int) onTabSelected;

  const _TabPills({
    required this.tabController,
    required this.selectedIndex,
    required this.computeCounts,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        final counts = state is FavoritesLoaded ? computeCounts(state) : <FavoriteType, int>{};

        return Container(
          color: context.backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: List.generate(_kTabs.length, (i) {
                final tab = _kTabs[i];
                final isSelected = selectedIndex == i;
                final count = counts[tab.type] ?? 0;

                return GestureDetector(
                  onTap: () => onTabSelected(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(colors: tab.gradient)
                          : null,
                      color: isSelected
                          ? null
                          : (isDark
                              ? Colors.white.withOpacity(0.07)
                              : Colors.black.withOpacity(0.05)),
                      borderRadius: BorderRadius.circular(50.r),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: tab.gradient.first.withOpacity(0.38),
                                blurRadius: 12.r,
                                offset: Offset(0, 4.h),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          tab.icon,
                          size: 15.sp,
                          color: isSelected
                              ? Colors.white
                              : context.textSecondaryColor.withOpacity(0.55),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          tab.label,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13.sp,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : context.textSecondaryColor.withOpacity(0.6),
                          ),
                        ),
                        if (count > 0) ...[
                          SizedBox(width: 6.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withOpacity(0.28)
                                  : tab.gradient.first.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              '$count',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w800,
                                color: isSelected
                                    ? Colors.white
                                    : tab.gradient.first,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

// ── Tab content ───────────────────────────────────────────────────────────────

class _TabContent extends StatelessWidget {
  final TabController tabController;
  const _TabContent({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
      builder: (context, exploreState) {
        if (exploreState is ExploreLoading || exploreState is ExploreInitial) {
          return _buildShimmer(context);
        }

        if (exploreState is ExploreLoaded) {
          return BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, favState) {
              if (favState is FavoriteInitial || favState is FavoriteLoading) {
                return _buildShimmer(context);
              }

              if (favState is FavoritesLoaded) {
                return TabBarView(
                  controller: tabController,
                  children: _kTabs
                      .map((tab) => _FavoriteTabPage(
                            tab: tab,
                            allFavorites: favState.favorites,
                            allItems: exploreState.allItems,
                          ))
                      .toList(),
                );
              }

              if (favState is FavoriteError) {
                return _buildError(context, favState.message);
              }

              return const SizedBox.shrink();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shimmerColor = isDark
        ? Colors.white.withOpacity(0.05)
        : Colors.black.withOpacity(0.04);
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 80.h),
      itemCount: 3,
      separatorBuilder: (_, _) => SizedBox(height: 16.h),
      itemBuilder: (_, i) => Container(
        height: i == 0 ? 200.h : 150.h,
        decoration: BoxDecoration(
          color: shimmerColor,
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off_rounded,
              size: 52.sp, color: Colors.redAccent.withOpacity(0.5)),
          SizedBox(height: 14.h),
          Text(
            'Could not load favorites',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            message,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.sp,
              color: context.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Per-tab page ──────────────────────────────────────────────────────────────

class _FavoriteTabPage extends StatelessWidget {
  final _TabMeta tab;
  final List<FavoriteEntity> allFavorites;
  final List<ExploreItemEntity> allItems;

  const _FavoriteTabPage({
    required this.tab,
    required this.allFavorites,
    required this.allItems,
  });

  bool _favMatchesTab(FavoriteEntity fav) {
    if (tab.type == FavoriteType.video) {
      return fav.contentType == FavoriteType.video ||
          fav.contentType == FavoriteType.longVideo ||
          fav.contentType == FavoriteType.shortVideo;
    }
    return fav.contentType == tab.type;
  }

  /// Rows keep every server favorite for this tab. Items missing from Explore
  /// still appear as [orphan] rows (they were hidden before when the catalog
  /// did not include that id yet).
  List<({FavoriteEntity fav, ExploreItemEntity? item})> _rows() {
    final out = <({FavoriteEntity fav, ExploreItemEntity? item})>[];
    for (final fav in allFavorites) {
      if (!_favMatchesTab(fav)) continue;
      ExploreItemEntity? match;
      for (final e in allItems) {
        if (e.id == fav.contentId) {
          match = e;
          break;
        }
      }
      out.add((fav: fav, item: match));
    }
    return out;
  }

  List<ExploreItemEntity> _resolvedItemsOnly(
    List<({FavoriteEntity fav, ExploreItemEntity? item})> rows,
  ) {
    return [for (final r in rows) if (r.item != null) r.item!];
  }

  @override
  Widget build(BuildContext context) {
    final rows = _rows();

    if (rows.isEmpty) return _EmptyTabState(tab: tab);

    final resolvedOnly = _resolvedItemsOnly(rows);

    if (tab.type == FavoriteType.image) {
      return GridView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 150 / 280,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemCount: rows.length,
        itemBuilder: (ctx, i) {
          final row = rows[i];
          if (row.item != null) {
            return _CardItem(
              item: row.item!,
              index: i,
              allItems: resolvedOnly,
            );
          }
          return _OrphanFavoriteTile(favorite: row.fav, tab: tab);
        },
      );
    }

    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
      itemCount: rows.length,
      separatorBuilder: (_, _) => SizedBox(height: 16.h),
      itemBuilder: (ctx, i) {
        final row = rows[i];
        if (row.item != null) {
          return _CardItem(
            item: row.item!,
            index: i,
            allItems: resolvedOnly,
          );
        }
        return _OrphanFavoriteTile(favorite: row.fav, tab: tab);
      },
    );
  }
}

// ── Favorite exists on server but Explore catalog has no row yet ─────────────

class _OrphanFavoriteTile extends StatelessWidget {
  final FavoriteEntity favorite;
  final _TabMeta tab;

  const _OrphanFavoriteTile({
    required this.favorite,
    required this.tab,
  });

  String? _userId(BuildContext context) {
    final auth = context.read<AuthBloc>().state;
    if (auth is AuthAuthenticated) return auth.user.id;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.06)
            : Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.borderColor.withOpacity(0.25),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: tab.gradient.first.withOpacity(0.2),
            child: Icon(tab.icon, color: tab.gradient.first, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saved ${tab.label.toLowerCase()}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'This favorite is not in your Explore feed yet. Open Explore and pull to refresh, or browse that content again.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    color: context.textSecondaryColor,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Remove from favorites',
            onPressed: () {
              final uid = _userId(context);
              if (uid == null || uid.isEmpty) return;
              context.read<FavoriteBloc>().add(
                    ToggleFavorite(
                      userId: uid,
                      contentId: favorite.contentId,
                      contentType: favorite.contentType,
                    ),
                  );
            },
            icon: Icon(
              Icons.favorite_rounded,
              color: Colors.redAccent,
              size: 26.sp,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyTabState extends StatelessWidget {
  final _TabMeta tab;
  const _EmptyTabState({required this.tab});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88.w,
              height: 88.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: tab.gradient
                      .map((c) => c.withOpacity(0.14))
                      .toList(),
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                tab.icon,
                size: 42.sp,
                color: tab.gradient.first.withOpacity(0.65),
              ),
            ),
            SizedBox(height: 22.h),
            Text(
              'No ${tab.label.toLowerCase()} saved yet',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: context.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              'Tap the ♥ icon on any ${tab.label.toLowerCase()} you love — it will appear right here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.sp,
                color: context.textSecondaryColor.withOpacity(0.6),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Single card item ──────────────────────────────────────────────────────────

class _CardItem extends StatelessWidget {
  final ExploreItemEntity item;
  final int index;
  final List<ExploreItemEntity> allItems;

  const _CardItem({
    required this.item,
    required this.index,
    required this.allItems,
  });

  // ── Mappers ────────────────────────────────────────────────────────────────

  AudioEntity _toAudio() => AudioEntity(
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

  VideoEntity _toVideo(VideoType type) => VideoEntity(
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

  QuoteEntity _toQuote() => QuoteEntity(
        id: item.id,
        quoteText: item.title,
        author: item.subtitle ?? 'Unknown',
        authorIconUrl: item.imageUrl,
        categoryId: item.categoryIds.isNotEmpty ? item.categoryIds.first : '',
        preferenceIds: item.tags,
        isFeatured: item.isFeatured,
        isPremium: item.isPremium,
        quoteType: 'quote',
        createdAt: item.createdAt,
        updatedAt: item.createdAt,
      );

  TipEntity _toTip(int idx) => TipEntity(
        id: item.id,
        title: item.title,
        tipText: item.description ?? '',
        author: item.subtitle ?? 'Expert',
        authorIconUrl: item.thumbnailUrl ?? '',
        categoryId: item.categoryIds.isNotEmpty ? item.categoryIds.first : '',
        preferenceIds: item.tags,
        tipType: TipType.general,
        isFeatured: item.isFeatured,
        isPremium: item.isPremium,
        sortOrder: 0,
        metadata: '',
        createdAt: item.createdAt,
        updatedAt: item.createdAt,
      );

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    switch (item.type) {
      // ── Audio ──────────────────────────────────────────────────────────────
      case ExploreItemType.audio:
        final audio = _toAudio();
        return SizedBox(
          width: double.infinity,
          height: 190.h,
          child: AudioCardWidget(
            track: audio,
            onTap: () => context.pushNamed(RouteNames.mediaPlayer, extra: audio),
          ),
        );

      // ── Short video ────────────────────────────────────────────────────────
      case ExploreItemType.shortVideo:
        final video = _toVideo(VideoType.shortForm);
        return SizedBox(
          width: double.infinity,
          height: 245.h,
          child: ShortVideoCardWidget(
            video: video,
            containerWidth: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.zero,
            onTap: () {
              final shorts = allItems
                  .where((i) => i.type == ExploreItemType.shortVideo)
                  .map((i) => _CardItem(item: i, index: 0, allItems: allItems)
                      ._toVideo(VideoType.shortForm))
                  .toList();
              final idx = shorts.indexWhere((s) => s.id == item.id);
              context.pushNamed(
                RouteNames.shortsPlayer,
                extra: shorts,
                queryParameters: {'index': '${idx < 0 ? 0 : idx}'},
              );
            },
          ),
        );

      // ── Long video ─────────────────────────────────────────────────────────
      case ExploreItemType.longVideo:
        final video = _toVideo(VideoType.longForm);
        return SizedBox(
          width: double.infinity,
          height: 300.h,
          child: LongVideoCardWidget(
            video: video,
            onTap: () =>
                context.pushNamed(RouteNames.longVideoPlayer, extra: video),
          ),
        );

      // ── Quote ──────────────────────────────────────────────────────────────
      case ExploreItemType.quote:
        final quote = _toQuote();
        return GestureDetector(
          onTap: () {
            final quotes = allItems
                .where((i) => i.type == ExploreItemType.quote)
                .map((i) =>
                    _CardItem(item: i, index: 0, allItems: allItems)._toQuote())
                .toList();
            final idx = quotes.indexWhere((q) => q.id == item.id);
            context.pushNamed(
              RouteNames.contentViewer,
              extra: {
                'quotes': quotes,
                'initialIndex': idx < 0 ? 0 : idx,
                'title': 'My Favorites',
              },
            );
          },
          child: SizedBox(
            height: 160.h,
            child: QuoteCardWidget(quote: quote),
          ),
        );

      // ── Tip ────────────────────────────────────────────────────────────────
      case ExploreItemType.tip:
        final tip = _toTip(index);
        return SizedBox(
          width: double.infinity,
          height: 280.h,
          child: TipCardWidget(
            tip: tip,
            onTap: () {
              final tips = allItems
                  .where((i) => i.type == ExploreItemType.tip)
                  .toList();
              final mappedTips = [
                for (var k = 0; k < tips.length; k++)
                  _CardItem(item: tips[k], index: k, allItems: allItems)
                      ._toTip(k),
              ];
              final idx = tips.indexWhere((t) => t.id == item.id);
              context.pushNamed(
                RouteNames.contentViewer,
                extra: {
                  'tips': mappedTips,
                  'initialIndex': idx < 0 ? 0 : idx,
                  'title': 'My Favorites',
                },
              );
            },
          ),
        );

      // ── Image ──────────────────────────────────────────────────────────────
      case ExploreItemType.image:
        return ExploreImageCard(
          item: item,
          onTap: () {
            final images = allItems
                .where((i) => i.type == ExploreItemType.image)
                .toList();
            final mappedImages = images
                .map((e) => ImageEntity(
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
                    ))
                .toList();
            final idx = images.indexWhere((i) => i.id == item.id);
            context.pushNamed(
              RouteNames.imageViewer,
              extra: {
                'images': mappedImages,
                'titles': images.map((e) => e.title).toList(),
                'subtitles': images.map((e) => e.subtitle ?? '').toList(),
                'initialIndex': idx < 0 ? 0 : idx,
                'categoryName': 'My Favorites',
              },
            );
          },
        );

      case ExploreItemType.category:
        return const SizedBox.shrink();
    }
  }
}
