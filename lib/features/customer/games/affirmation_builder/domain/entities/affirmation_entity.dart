import 'package:equatable/equatable.dart';

class AffirmationEntity extends Equatable {
  final String id;
  final String userId;
  final String text;
  final String backgroundColor;
  final String iconName;
  final DateTime createdAt;

  final List<String> words;
  final int difficulty;
  final String category;

  const AffirmationEntity({
    required this.id,
    required this.userId,
    required this.text,
    required this.backgroundColor,
    required this.iconName,
    required this.createdAt,
    this.words = const [],
    this.difficulty = 1,
    this.category = 'General',
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        text,
        backgroundColor,
        iconName,
        createdAt,
        words,
        difficulty,
        category,
      ];
}
