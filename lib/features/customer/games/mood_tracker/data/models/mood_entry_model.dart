import 'package:Resilio/core/proto_generated/games.pb.dart' as pb;
import 'package:Resilio/features/customer/games/mood_tracker/domain/entities/mood_entry_entity.dart';

class MoodEntryModel extends MoodEntryEntity {
  const MoodEntryModel({
    required super.id,
    required super.userId,
    required super.moodScore,
    required super.moodLabel,
    required super.note,
    required super.entryDate,
    required super.createdAt,
  });

  factory MoodEntryModel.fromProto(pb.MoodEntry proto) {
    return MoodEntryModel(
      id: proto.id,
      userId: proto.userId,
      moodScore: proto.moodScore,
      moodLabel: proto.moodLabel,
      note: proto.note,
      entryDate: proto.entryDate,
      createdAt: DateTime.tryParse(proto.createdAt) ?? DateTime.now(),
    );
  }
}
