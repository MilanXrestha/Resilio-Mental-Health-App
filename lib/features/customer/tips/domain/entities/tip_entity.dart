import 'package:equatable/equatable.dart';

/// Tip type enum for different wellness tip categories
enum TipType {
  relationshipBooster, // Tips for strengthening relationships
  lettingGo, // Tips for releasing attachments
  communication, // Tips for better communication
  selfCare, // Tips for personal wellness
  mindfulness, // Tips for present-moment awareness
  general, // General wellness tips
  unknown,
}

/// Tip entity representing a wellness tip or advice
class TipEntity extends Equatable {
  final String id;
  final String title;
  final String tipText;
  final String author;
  final String authorIconUrl;
  final String categoryId;
  final List<String> preferenceIds;
  final TipType tipType;
  final bool isFeatured;
  final bool isPremium;
  final int sortOrder;
  final String metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TipEntity({
    required this.id,
    required this.title,
    required this.tipText,
    required this.author,
    required this.authorIconUrl,
    required this.categoryId,
    required this.preferenceIds,
    required this.tipType,
    required this.isFeatured,
    required this.isPremium,
    required this.sortOrder,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a copy with updated fields
  TipEntity copyWith({
    String? id,
    String? title,
    String? tipText,
    String? author,
    String? authorIconUrl,
    String? categoryId,
    List<String>? preferenceIds,
    TipType? tipType,
    bool? isFeatured,
    bool? isPremium,
    int? sortOrder,
    String? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TipEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      tipText: tipText ?? this.tipText,
      author: author ?? this.author,
      authorIconUrl: authorIconUrl ?? this.authorIconUrl,
      categoryId: categoryId ?? this.categoryId,
      preferenceIds: preferenceIds ?? this.preferenceIds,
      tipType: tipType ?? this.tipType,
      isFeatured: isFeatured ?? this.isFeatured,
      isPremium: isPremium ?? this.isPremium,
      sortOrder: sortOrder ?? this.sortOrder,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Get formatted tip type as string
  String get tipTypeString {
    switch (tipType) {
      case TipType.relationshipBooster:
        return 'Relationship Booster';
      case TipType.lettingGo:
        return 'Letting Go';
      case TipType.communication:
        return 'Communication';
      case TipType.selfCare:
        return 'Self-Care';
      case TipType.mindfulness:
        return 'Mindfulness';
      case TipType.general:
        return 'General';
      case TipType.unknown:
        return 'Unknown';
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        tipText,
        author,
        authorIconUrl,
        categoryId,
        preferenceIds,
        tipType,
        isFeatured,
        isPremium,
        sortOrder,
        metadata,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'TipEntity(id: $id, title: $title, tipType: $tipType)';
  }
}
