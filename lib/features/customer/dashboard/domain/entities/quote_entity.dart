import 'package:equatable/equatable.dart';

/// Quote entity representing a featured quote or tip
class QuoteEntity extends Equatable {
  final String id;
  final String quoteText;
  final String author;
  final String? authorIconUrl;
  final String? categoryId;
  final List<String> preferenceIds;
  final bool isFeatured;
  final bool isPremium;
  final String quoteType; // 'quote', 'tip', or 'affirmation'
  final DateTime createdAt;
  final DateTime updatedAt;

  const QuoteEntity({
    required this.id,
    required this.quoteText,
    required this.author,
    this.authorIconUrl,
    this.categoryId,
    required this.preferenceIds,
    required this.isFeatured,
    required this.isPremium,
    required this.quoteType,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create a copy with updated fields
  QuoteEntity copyWith({
    String? id,
    String? quoteText,
    String? author,
    String? authorIconUrl,
    String? categoryId,
    List<String>? preferenceIds,
    bool? isFeatured,
    bool? isPremium,
    String? quoteType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return QuoteEntity(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      author: author ?? this.author,
      authorIconUrl: authorIconUrl ?? this.authorIconUrl,
      categoryId: categoryId ?? this.categoryId,
      preferenceIds: preferenceIds ?? this.preferenceIds,
      isFeatured: isFeatured ?? this.isFeatured,
      isPremium: isPremium ?? this.isPremium,
      quoteType: quoteType ?? this.quoteType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        quoteText,
        author,
        authorIconUrl,
        categoryId,
        preferenceIds,
        isFeatured,
        isPremium,
        quoteType,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() => 'QuoteEntity(id: $id, quoteText: $quoteText, author: $author)';
}
