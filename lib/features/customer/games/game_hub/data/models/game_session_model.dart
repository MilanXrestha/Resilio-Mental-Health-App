import 'package:Resilio/core/proto_generated/games.pb.dart' as pb;
import 'package:Resilio/features/customer/games/game_hub/domain/entities/game_session_entity.dart';

class GameSessionModel extends GameSessionEntity {
  const GameSessionModel({
    required super.id,
    required super.userId,
    required super.gameType,
    required super.durationSeconds,
    required super.score,
    required super.metadata,
    required super.startTime,
    super.endTime,
    required super.createdAt,
  });

  factory GameSessionModel.fromProto(pb.GameSession proto) {
    return GameSessionModel(
      id: proto.id,
      userId: proto.userId,
      gameType: proto.gameType,
      durationSeconds: proto.durationSeconds,
      score: proto.score,
      metadata: proto.metadata,
      startTime: DateTime.tryParse(proto.startTime) ?? DateTime.now(),
      endTime: proto.endTime.isNotEmpty ? DateTime.tryParse(proto.endTime) : null,
      createdAt: DateTime.tryParse(proto.createdAt) ?? DateTime.now(),
    );
  }
}
