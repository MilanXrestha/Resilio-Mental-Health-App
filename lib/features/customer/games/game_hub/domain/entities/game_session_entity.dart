import 'package:equatable/equatable.dart';

class GameSessionEntity extends Equatable {
  final String id;
  final String userId;
  final String gameType;
  final int durationSeconds;
  final int score;
  final String metadata;
  final DateTime startTime;
  final DateTime? endTime;
  final DateTime createdAt;

  const GameSessionEntity({
    required this.id,
    required this.userId,
    required this.gameType,
    required this.durationSeconds,
    required this.score,
    required this.metadata,
    required this.startTime,
    this.endTime,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        gameType,
        durationSeconds,
        score,
        metadata,
        startTime,
        endTime,
        createdAt,
      ];
}
