import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Resilio/core/proto_generated/games.pb.dart' as pb;
import 'package:Resilio/features/customer/games/affirmation_builder/domain/entities/affirmation_entity.dart';

class AffirmationModel extends AffirmationEntity {
  const AffirmationModel({
    required super.id,
    required super.userId,
    required super.text,
    required super.backgroundColor,
    required super.iconName,
    required super.createdAt,
    super.words,
    super.difficulty,
    super.category,
  });

  factory AffirmationModel.fromProto(pb.Affirmation proto) {
    return AffirmationModel(
      id: proto.id,
      userId: proto.userId,
      text: proto.text,
      backgroundColor: proto.backgroundColor,
      iconName: proto.iconName,
      createdAt: DateTime.tryParse(proto.createdAt) ?? DateTime.now(),
      words: proto.words,
      difficulty: proto.difficulty,
      category: proto.category,
    );
  }

  factory AffirmationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AffirmationModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      text: data['text'] ?? '',
      backgroundColor: data['backgroundColor'] ?? '0xFFFFFFFF',
      iconName: data['iconName'] ?? 'favorite',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      words: List<String>.from(data['words'] ?? []),
      difficulty: data['difficulty'] ?? 1,
      category: data['category'] ?? 'General',
    );
  }

  List<String> getShuffledWords() {
    final shuffled = List<String>.from(words);
    shuffled.shuffle(Random());
    return shuffled;
  }
}
