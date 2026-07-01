import 'package:Resilio/core/di/injection.dart';
import 'package:Resilio/features/customer/games/affirmation_builder/data/models/affirmation_model.dart';
import 'package:Resilio/features/customer/games/mood_tracker/data/models/mood_entry_model.dart';
import 'package:Resilio/features/customer/games/game_hub/domain/repositories/games_repository.dart';
import 'package:Resilio/features/customer/games/wellness_trivia/data/models/quiz_question_model.dart';

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
    int moodScore = 3,
    String? note,
  }) async {
    await _gamesRepository.saveMoodEntry(
      moodScore: moodScore,
      moodLabel: mood,
      note: note ?? '',
      entryDate: DateTime.now().toIso8601String().split('T')[0],
    );
  }

  Future<MoodEntryModel?> updateMoodEntry({
    required String id,
    required String mood,
    int moodScore = 3,
    String note = '',
  }) async {
    final result = await _gamesRepository.updateMoodEntry(
      id: id,
      moodScore: moodScore,
      moodLabel: mood,
      note: note,
    );
    return result.fold(
      (l) => null,
      (entry) => MoodEntryModel(
        id: entry.id,
        userId: entry.userId,
        moodScore: entry.moodScore,
        moodLabel: entry.moodLabel,
        note: entry.note,
        entryDate: entry.entryDate,
        createdAt: entry.createdAt,
      ),
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
    final entries = await getUserMoodEntries(userId, limit: 100);
    if (entries.isEmpty) {
      return {'mostFrequentMood': null, 'totalEntries': 0, 'currentStreak': 0};
    }

    // Count mood frequency
    final moodCounts = <String, int>{};
    for (final e in entries) {
      moodCounts[e.moodLabel] = (moodCounts[e.moodLabel] ?? 0) + 1;
    }
    final mostFrequent = moodCounts.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;

    // Compute streak (consecutive days ending today)
    final today = DateTime.now();
    final entryDates = entries
        .map((e) => DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day))
        .toSet();
    int streak = 0;
    for (int i = 0; i < 365; i++) {
      final day = DateTime(today.year, today.month, today.day - i);
      if (entryDates.contains(day)) {
        streak++;
      } else {
        break;
      }
    }

    return {
      'mostFrequentMood': mostFrequent,
      'totalEntries': entries.length,
      'currentStreak': streak,
    };
  }

  Future<List<QuizQuestionModel>> loadQuizQuestions() async {
    final result = await _gamesRepository.listQuizQuestions();
    return result.fold((l) => [], (questions) => questions);
  }

  Future<List<AffirmationModel>> loadAffirmationPuzzles() async {
    final result = await _gamesRepository.listAffirmationPuzzles();
    return result.fold((l) => [], (puzzles) => puzzles);
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
