import 'package:dartz/dartz.dart';

import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/features/customer/games/achievements/domain/entities/achievement_entity.dart';
import 'package:Resilio/features/customer/games/affirmation_builder/domain/entities/affirmation_entity.dart';
import 'package:Resilio/features/customer/games/affirmation_builder/data/models/affirmation_model.dart';
import 'package:Resilio/features/customer/games/game_hub/domain/entities/game_session_entity.dart';
import 'package:Resilio/features/customer/games/mood_tracker/domain/entities/mood_entry_entity.dart';
import 'package:Resilio/features/customer/games/wellness_trivia/data/models/quiz_question_model.dart';

abstract class GamesRepository {
  Future<Either<Failure, GameSessionEntity>> saveGameSession({
    required String gameType,
    required int durationSeconds,
    required int score,
    required String metadata,
  });

  Future<Either<Failure, MoodEntryEntity>> saveMoodEntry({
    required int moodScore,
    required String moodLabel,
    required String note,
    required String entryDate,
  });

  Future<Either<Failure, MoodEntryEntity>> updateMoodEntry({
    required String id,
    required int moodScore,
    required String moodLabel,
    required String note,
  });

  Future<Either<Failure, List<MoodEntryEntity>>> listMoodEntries({
    String? fromDate,
    String? toDate,
  });

  Future<Either<Failure, List<AchievementEntity>>> listUserAchievements();

  /// Returns the total count of game sessions played by the current user.
  Future<Either<Failure, int>> listGameSessions();

  Future<Either<Failure, List<QuizQuestionModel>>> listQuizQuestions();

  Future<Either<Failure, List<AffirmationModel>>> listAffirmationPuzzles();

  Future<Either<Failure, List<AchievementEntity>>> listAllAchievements();

  Future<Either<Failure, AffirmationEntity>> saveAffirmation({
    required String text,
    required String backgroundColor,
    required String iconName,
  });

  Future<Either<Failure, List<AffirmationEntity>>> listAffirmations();

  Future<Either<Failure, void>> deleteAffirmation(String id);
}
