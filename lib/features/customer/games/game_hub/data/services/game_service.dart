import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/features/customer/games/achievements/data/models/achievement_model.dart';
import 'package:Resilio/features/customer/games/mood_tracker/data/models/mood_entry_model.dart';
import 'package:Resilio/features/customer/games/game_hub/domain/repositories/games_repository.dart';

class GameService {
  final GamesRepository _gamesRepository = getIt<GamesRepository>();

  Future<void> saveGameSession({
    required String userId,
    required String gameId,
    required int score,
    required int streak,
    required Duration duration,
    Map<String, dynamic> sessionData = const {},
  }) async {
    await _gamesRepository.saveGameSession(
      gameType: gameId,
      durationSeconds: duration.inSeconds,
      score: score,
      metadata: sessionData.toString(),
    );
  }

  Future<List<Map<String, dynamic>>> getUserAchievements(String userId) async {
    final result = await _gamesRepository.listUserAchievements();
    return result.fold(
      (l) => [],
      (achievements) => achievements.map((a) => {
        'id': a.id,
        'achievementId': a.achievementId,
        'title': a.name,
        'description': a.description,
        'iconPath': a.iconUrl,
        'gameId': 'global',
        'pointsAwarded': 10,
        'unlockedAt': a.unlockedAt.toIso8601String(),
        'isNew': false,
      }).toList(),
    );
  }

  Future<List<Map<String, dynamic>>> getAllAchievements() async {
    final result = await _gamesRepository.listAllAchievements();
    return result.fold(
      (l) => [],
      (achievements) => achievements.map((a) => {
        'id': a.id,
        'achievementId': a.achievementId,
        'title': a.name,
        'description': a.description,
        'iconPath': a.iconUrl,
        'gameId': 'global',
        'pointsAwarded': 10,
        'unlocked': false,
      }).toList(),
    );
  }

  Future<void> saveMoodEntry({
    required String userId,
    required String mood,
    String? note,
  }) async {
    int score = 3;
    if (mood.toLowerCase().contains('happy')) score = 5;
    if (mood.toLowerCase().contains('sad')) score = 1;

    await _gamesRepository.saveMoodEntry(
      moodScore: score,
      moodLabel: mood,
      note: note ?? '',
      entryDate: DateTime.now().toIso8601String().split('T')[0],
    );
  }

  Future<List<MoodEntryModel>> getUserMoodEntries(String userId, {int limit = 10}) async {
    final result = await _gamesRepository.listMoodEntries();
    return result.fold(
      (l) => [],
      (entries) => entries.map((e) => MoodEntryModel(
        id: e.id,
        userId: e.userId,
        moodScore: e.moodScore,
        moodLabel: e.moodLabel,
        note: e.note,
        entryDate: e.entryDate,
        createdAt: e.createdAt,
      )).toList(),
    );
  }

  Future<Map<String, dynamic>> getUserMoodStats(String userId) async {
    return {'mostFrequentMood': 'Happy', 'totalEntries': 0};
  }

  Future<List<dynamic>> getUserProgress(String userId) async {
    return [];
  }
  
  Future<dynamic> getUserGameProgress(String userId, String gameId) async {
    return null;
  }
  
  Future<void> unlockAchievement({
    required String userId,
    required String achievementId,
  }) async {
  }
  
  Future<List<Map<String, dynamic>>> getGameAchievements(String gameId) async {
    return [];
  }
}
