import 'package:equatable/equatable.dart';

class AchievementEntity extends Equatable {
  final String id;
  final String userId;
  final String achievementId;
  final DateTime unlockedAt;
  final String code;
  final String name;
  final String description;
  final String iconUrl;

  const AchievementEntity({
    required this.id,
    required this.userId,
    required this.achievementId,
    required this.unlockedAt,
    required this.code,
    required this.name,
    required this.description,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        achievementId,
        unlockedAt,
        code,
        name,
        description,
        iconUrl,
      ];
}
