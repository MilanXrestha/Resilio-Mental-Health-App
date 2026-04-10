import 'package:Resilio/core/proto_generated/games.pb.dart' as pb;
import 'package:Resilio/features/customer/games/achievements/domain/entities/achievement_entity.dart';

class AchievementModel extends AchievementEntity {
  const AchievementModel({
    required super.id,
    required super.userId,
    required super.achievementId,
    required super.unlockedAt,
    required super.code,
    required super.name,
    required super.description,
    required super.iconUrl,
  });

  factory AchievementModel.fromProto(pb.UserAchievement proto) {
    return AchievementModel(
      id: proto.id,
      userId: proto.userId,
      achievementId: proto.achievementId,
      unlockedAt: DateTime.tryParse(proto.unlockedAt) ?? DateTime.now(),
      code: proto.hasAchievement() ? proto.achievement.code : '',
      name: proto.hasAchievement() ? proto.achievement.name : '',
      description: proto.hasAchievement() ? proto.achievement.description : '',
      iconUrl: proto.hasAchievement() ? proto.achievement.iconUrl : '',
    );
  }
}
