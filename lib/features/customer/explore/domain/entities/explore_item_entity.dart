import 'package:equatable/equatable.dart';

/// Unified explore item entity that wraps different content types
enum ExploreItemType {
  audio,
  shortVideo,
  longVideo,
  quote,
  tip,
  image,
  category,
}

class ExploreItemEntity extends Equatable {
  final String id;
  final String title;
  final String? subtitle;
  final String? description;
  final String? imageUrl;
  final String? thumbnailUrl;
  final ExploreItemType type;
  final List<String> tags;
  final List<String> categoryIds;
  final bool isFeatured;
  final bool isPremium;
  final int? durationSeconds;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;

  const ExploreItemEntity({
    required this.id,
    required this.title,
    this.subtitle,
    this.description,
    this.imageUrl,
    this.thumbnailUrl,
    required this.type,
    this.tags = const [],
    this.categoryIds = const [],
    this.isFeatured = false,
    this.isPremium = false,
    this.durationSeconds,
    required this.createdAt,
    this.metadata,
  });

  /// Search relevance score based on query match
  int searchScore(String query) {
    if (query.isEmpty) return 0;

    final lowerQuery = query.toLowerCase();
    int score = 0;

    // Title match (highest priority)
    if (title.toLowerCase().contains(lowerQuery)) {
      score += 100;
      if (title.toLowerCase().startsWith(lowerQuery)) {
        score += 50;
      }
    }

    // Subtitle match
    if (subtitle?.toLowerCase().contains(lowerQuery) ?? false) {
      score += 50;
    }

    // Description match
    if (description?.toLowerCase().contains(lowerQuery) ?? false) {
      score += 25;
    }

    // Tags match
    for (final tag in tags) {
      if (tag.toLowerCase().contains(lowerQuery)) {
        score += 30;
      }
    }

    return score;
  }

  /// Check if item matches the given filters
  bool matchesFilters({
    List<ExploreItemType>? types,
    List<String>? categoryIds,
    bool? isFeaturedOnly,
    bool? isPremiumOnly,
    int? minDuration,
    int? maxDuration,
  }) {
    // Type filter
    if (types != null && types.isNotEmpty && !types.contains(type)) {
      return false;
    }

    // Category filter
    if (categoryIds != null && categoryIds.isNotEmpty) {
      final hasMatchingCategory = this.categoryIds.any(
            (id) => categoryIds.contains(id),
      );
      if (!hasMatchingCategory && this.categoryIds.isNotEmpty) {
        return false;
      }
    }

    // Featured filter
    if (isFeaturedOnly == true && !isFeatured) {
      return false;
    }

    // Premium filter
    if (isPremiumOnly == true && !isPremium) {
      return false;
    }

    // Duration filter
    if (durationSeconds != null) {
      if (minDuration != null && durationSeconds! < minDuration) {
        return false;
      }
      if (maxDuration != null && durationSeconds! > maxDuration) {
        return false;
      }
    }

    return true;
  }

  /// Formatted duration string
  String? get formattedDuration {
    if (durationSeconds == null) return null;
    final minutes = durationSeconds! ~/ 60;
    final seconds = durationSeconds! % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Type display name
  String get typeDisplayName {
    switch (type) {
      case ExploreItemType.audio:
        return 'Audio';
      case ExploreItemType.shortVideo:
        return 'Short';
      case ExploreItemType.longVideo:
        return 'Video';
      case ExploreItemType.quote:
        return 'Quote';
      case ExploreItemType.tip:
        return 'Tip';
      case ExploreItemType.image:
        return 'Image';
      case ExploreItemType.category:
        return 'Category';
    }
  }

  ExploreItemEntity copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    String? imageUrl,
    String? thumbnailUrl,
    ExploreItemType? type,
    List<String>? tags,
    List<String>? categoryIds,
    bool? isFeatured,
    bool? isPremium,
    int? durationSeconds,
    DateTime? createdAt,
    Map<String, dynamic>? metadata,
  }) {
    return ExploreItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      type: type ?? this.type,
      tags: tags ?? this.tags,
      categoryIds: categoryIds ?? this.categoryIds,
      isFeatured: isFeatured ?? this.isFeatured,
      isPremium: isPremium ?? this.isPremium,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      createdAt: createdAt ?? this.createdAt,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    description,
    imageUrl,
    thumbnailUrl,
    type,
    tags,
    categoryIds,
    isFeatured,
    isPremium,
    durationSeconds,
    createdAt,
    metadata,
  ];
}

/// Filter configuration for explore
class ExploreFilter extends Equatable {
  final String? searchQuery;
  final List<ExploreItemType> types;
  final List<String> categoryIds;
  final bool? isFeaturedOnly;
  final bool? isPremiumOnly;
  final int? minDuration;
  final int? maxDuration;
  final ExploreSortBy sortBy;
  final bool sortDescending;

  const ExploreFilter({
    this.searchQuery,
    this.types = const [],
    this.categoryIds = const [],
    this.isFeaturedOnly,
    this.isPremiumOnly,
    this.minDuration,
    this.maxDuration,
    this.sortBy = ExploreSortBy.relevance,
    this.sortDescending = true,
  });

  bool get hasActiveFilters =>
      types.isNotEmpty ||
          categoryIds.isNotEmpty ||
          isFeaturedOnly == true ||
          isPremiumOnly == true ||
          minDuration != null ||
          maxDuration != null;

  int get activeFilterCount {
    int count = 0;
    if (types.isNotEmpty) count++;
    if (categoryIds.isNotEmpty) count++;
    if (isFeaturedOnly == true) count++;
    if (isPremiumOnly == true) count++;
    if (minDuration != null || maxDuration != null) count++;
    return count;
  }

  ExploreFilter copyWith({
    String? searchQuery,
    List<ExploreItemType>? types,
    List<String>? categoryIds,
    bool? isFeaturedOnly,
    bool? isPremiumOnly,
    int? minDuration,
    int? maxDuration,
    ExploreSortBy? sortBy,
    bool? sortDescending,
  }) {
    return ExploreFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      types: types ?? this.types,
      categoryIds: categoryIds ?? this.categoryIds,
      isFeaturedOnly: isFeaturedOnly ?? this.isFeaturedOnly,
      isPremiumOnly: isPremiumOnly ?? this.isPremiumOnly,
      minDuration: minDuration ?? this.minDuration,
      maxDuration: maxDuration ?? this.maxDuration,
      sortBy: sortBy ?? this.sortBy,
      sortDescending: sortDescending ?? this.sortDescending,
    );
  }

  ExploreFilter clearFilters() {
    return ExploreFilter(
      searchQuery: searchQuery,
      sortBy: sortBy,
      sortDescending: sortDescending,
    );
  }

  @override
  List<Object?> get props => [
    searchQuery,
    types,
    categoryIds,
    isFeaturedOnly,
    isPremiumOnly,
    minDuration,
    maxDuration,
    sortBy,
    sortDescending,
  ];
}

enum ExploreSortBy {
  relevance,
  newest,
  oldest,
  title,
  duration,
}