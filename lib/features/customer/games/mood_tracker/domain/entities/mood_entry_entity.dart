import 'package:equatable/equatable.dart';

class MoodEntryEntity extends Equatable {
  final String id;
  final String userId;
  final int moodScore;
  final String moodLabel;
  final String note;
  final String entryDate;
  final DateTime createdAt;

  const MoodEntryEntity({
    required this.id,
    required this.userId,
    required this.moodScore,
    required this.moodLabel,
    required this.note,
    required this.entryDate,
    required this.createdAt,
  });

  @override
  List<Object> get props => [
        id,
        userId,
        moodScore,
        moodLabel,
        note,
        entryDate,
        createdAt,
      ];
}
