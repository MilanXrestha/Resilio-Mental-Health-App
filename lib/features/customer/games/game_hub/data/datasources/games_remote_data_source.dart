import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/exceptions.dart';
import 'package:Resilio/core/proto_generated/games.pb.dart' as pb;
import 'package:Resilio/features/customer/games/achievements/data/models/achievement_model.dart';
import 'package:Resilio/features/customer/games/affirmation_builder/data/models/affirmation_model.dart';
import 'package:Resilio/features/customer/games/mood_tracker/data/models/mood_entry_model.dart';
import 'package:Resilio/features/customer/games/game_hub/data/models/game_session_model.dart';
import 'package:Resilio/features/customer/games/wellness_trivia/data/models/quiz_question_model.dart';

abstract class GamesRemoteDataSource {
  Future<GameSessionModel> saveGameSession({
    required String gameType,
    required int durationSeconds,
    required int score,
    required String metadata,
  });

  Future<MoodEntryModel> saveMoodEntry({
    required int moodScore,
    required String moodLabel,
    required String note,
    required String entryDate,
  });

  Future<MoodEntryModel> updateMoodEntry({
    required String id,
    required int moodScore,
    required String moodLabel,
    required String note,
  });

  Future<List<MoodEntryModel>> listMoodEntries({
    String? fromDate,
    String? toDate,
  });

  Future<List<AchievementModel>> listUserAchievements();

  Future<int> listGameSessionsCount();

  Future<List<QuizQuestionModel>> listQuizQuestions();

  Future<List<AffirmationModel>> listAffirmationPuzzles();

  Future<List<AchievementModel>> listAllAchievements();

  Future<AffirmationModel> saveAffirmation({
    required String text,
    required String backgroundColor,
    required String iconName,
  });

  Future<List<AffirmationModel>> listAffirmations();

  Future<void> deleteAffirmation(String id);
}

@LazySingleton(as: GamesRemoteDataSource)
class GamesRemoteDataSourceImpl implements GamesRemoteDataSource {
  final Dio _dio;

  GamesRemoteDataSourceImpl(this._dio);

  @override
  Future<GameSessionModel> saveGameSession({
    required String gameType,
    required int durationSeconds,
    required int score,
    required String metadata,
  }) async {
    try {
      final response = await _dio.post(
        '/games/session',
        data: {
          'game_type': gameType,
          'duration_seconds': durationSeconds,
          'score': score,
          'metadata': metadata,
        },
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.GameSession.fromBuffer(response.data);
      return GameSessionModel.fromProto(pbResponse);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to save game session');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MoodEntryModel> saveMoodEntry({
    required int moodScore,
    required String moodLabel,
    required String note,
    required String entryDate,
  }) async {
    try {
      final response = await _dio.post(
        '/games/mood',
        data: {
          'mood_score': moodScore,
          'mood_label': moodLabel,
          'note': note,
          'entry_date': entryDate,
        },
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.MoodEntry.fromBuffer(response.data);
      return MoodEntryModel.fromProto(pbResponse);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to save mood entry');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MoodEntryModel> updateMoodEntry({
    required String id,
    required int moodScore,
    required String moodLabel,
    required String note,
  }) async {
    try {
      final response = await _dio.patch(
        '/games/mood/$id',
        data: {
          'mood_score': moodScore,
          'mood_label': moodLabel,
          'note': note,
        },
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.MoodEntry.fromBuffer(response.data);
      return MoodEntryModel.fromProto(pbResponse);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to update mood entry');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<MoodEntryModel>> listMoodEntries({
    String? fromDate,
    String? toDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (fromDate != null) queryParams['from_date'] = fromDate;
      if (toDate != null) queryParams['to_date'] = toDate;

      final response = await _dio.get(
        '/games/mood',
        queryParameters: queryParams,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.ListMoodEntriesResponse.fromBuffer(response.data);
      return pbResponse.entries.map((e) => MoodEntryModel.fromProto(e)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to list mood entries');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<AchievementModel>> listUserAchievements() async {
    try {
      final response = await _dio.get(
        '/games/achievements',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.ListUserAchievementsResponse.fromBuffer(response.data);
      return pbResponse.achievements.map((e) => AchievementModel.fromProto(e)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to list achievements');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<AchievementModel>> listAllAchievements() async {
    try {
      final response = await _dio.get(
        '/games/achievements/all',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.ListUserAchievementsResponse.fromBuffer(response.data);
      return pbResponse.achievements.map((e) => AchievementModel.fromProto(e)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to list all achievements');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AffirmationModel> saveAffirmation({
    required String text,
    required String backgroundColor,
    required String iconName,
  }) async {
    try {
      final response = await _dio.post(
        '/games/affirmations',
        data: {
          'text': text,
          'background_color': backgroundColor,
          'icon_name': iconName,
        },
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.Affirmation.fromBuffer(response.data);
      return AffirmationModel.fromProto(pbResponse);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to save affirmation');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<int> listGameSessionsCount() async {
    try {
      final response = await _dio.get(
        '/games/sessions',
        options: Options(headers: {'Accept': 'application/json'}),
      );
      final data = response.data as Map<String, dynamic>;
      return (data['total'] as int?) ?? 0;
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to list game sessions');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<QuizQuestionModel>> listQuizQuestions() async {
    try {
      final response = await _dio.get(
        '/games/quiz-questions',
        options: Options(headers: {'Accept': 'application/json'}),
      );
      final data = response.data as Map<String, dynamic>;
      final list = data['questions'] as List? ?? [];
      return list
          .map((q) => QuizQuestionModel.fromJson(q as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load quiz questions');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<AffirmationModel>> listAffirmationPuzzles() async {
    try {
      final response = await _dio.get(
        '/games/affirmation-puzzles',
        options: Options(headers: {'Accept': 'application/json'}),
      );
      final data = response.data as Map<String, dynamic>;
      final list = data['puzzles'] as List? ?? [];
      return list
          .map((p) => AffirmationModel.fromJson(p as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load affirmation puzzles');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<AffirmationModel>> listAffirmations() async {
    try {
      final response = await _dio.get(
        '/games/affirmations',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );

      final pbResponse = pb.ListAffirmationsResponse.fromBuffer(response.data);
      return pbResponse.affirmations.map((e) => AffirmationModel.fromProto(e)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to list affirmations');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteAffirmation(String id) async {
    try {
      await _dio.delete(
        '/games/affirmations/$id',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/x-protobuf'},
        ),
      );
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to delete affirmation');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
