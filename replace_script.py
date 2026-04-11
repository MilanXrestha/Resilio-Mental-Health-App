import sys

file_path = "lib/features/customer/explore/presentation/screens/explore_screen.dart"
with open(file_path, "r") as f:
    lines = f.readlines()

def find_line(prefix):
    for i, line in enumerate(lines):
        if line.startswith(prefix): return i
    return -1

start1 = find_line("  Widget _buildSectionedContent(")
end1 = find_line("  Widget _buildEmptyState(")

if start1 != -1 and end1 != -1:
    new_build_sectioned = """  Widget _buildSectionedContent(
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
        ...categories.map((category) {
          final items = itemsByCategory[category.id] ?? [];
          if (items.isEmpty) return const SizedBox.shrink();
          return _CategoryContentSection(
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
          );
        }),
        if (uncategorized.isNotEmpty)
          _CategoryContentSection(
            categoryTitle: 'Other Content',
            items: uncategorized,
            allItems: state.allItems,
          ),
        SizedBox(height: 100.h),
      ],
    );
  }

"""
    lines[start1:end1] = [new_build_sectioned]


start2 = find_line("// ─────────────────────────────────────────────────────────────────────────────")
# We want the FIRST occurrence of the separator that comes after _SectionHeader (around line 718)
# Let's find _AudioSection
audio_sec = find_line("class _AudioSection extends StatelessWidget {")
if audio_sec != -1:
    start2 = audio_sec - 4  # The separator above it

# Remove everything from start2 down to "class _ExploreImageCard" or the end of the file
new_block = """
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
          height: 300.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 16.w),
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

  Widget _buildCardForItem(BuildContext context, ExploreItemEntity item, int index) {
    switch (item.type) {
      case ExploreItemType.audio:
        final audio = _toAudioEntity(item);
        return AudioCardWidget(
          track: audio,
          onTap: () => context.pushNamed(RouteNames.mediaPlayer, extra: audio),
        );

      case ExploreItemType.shortVideo:
        return ShortVideoCardWidget(
          video: _toVideoEntity(item, VideoType.shortForm),
          onTap: () {
            final videos = items
                .where((i) => i.type == ExploreItemType.shortVideo)
                .map((i) => _toVideoEntity(i, VideoType.shortForm))
                .toList();
            context.pushNamed(RouteNames.shortsPlayer, extra: videos);
          },
        );

      case ExploreItemType.longVideo:
        final video = _toVideoEntity(item, VideoType.longForm);
        return SizedBox(
          width: 320.w,
          child: LongVideoCardWidget(
            video: video,
            onTap: () => context.pushNamed(RouteNames.longVideoPlayer, extra: video),
          ),
        );

      case ExploreItemType.quote:
        final quote = _toQuoteEntity(item);
        return QuoteCardWidget(
          quote: quote,
          onTap: () => _showQuoteDetail(context, item),
        );

      case ExploreItemType.tip:
        final tip = _toTipEntity(item, index);
        return SizedBox(
          width: 260.w,
          child: TipCardWidget(
            tip: tip,
            onTap: () => _showTipDetail(context, item),
          ),
        );

      case ExploreItemType.image:
        return ExploreImageCard(
          item: item,
          onTap: () => _showImageDetail(context, item),
        );

      case ExploreItemType.category:
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
    final tips = [for (var i = 0; i < tipItems.length; i++) _toTipEntity(tipItems[i], i)];
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
    final imageItems = items.where((e) => e.type == ExploreItemType.image).toList();
    final images = imageItems.map((e) => ImageEntity(
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
    )).toList();
    
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
"""

if start2 != -1:
    lines[start2:] = [new_block]

with open(file_path, "w") as f:
    f.writelines(lines)
