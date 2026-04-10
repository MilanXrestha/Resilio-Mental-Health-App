import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/exceptions.dart';
import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/network/network_info.dart';
import 'package:Resilio/features/customer/games/game_hub/data/datasources/games_remote_data_source.dart';
import 'package:Resilio/features/customer/games/achievements/domain/entities/achievement_entity.dart';
import 'package:Resilio/features/customer/games/affirmation_builder/domain/entities/affirmation_entity.dart';
import 'package:Resilio/features/customer/games/game_hub/domain/entities/game_session_entity.dart';
import 'package:Resilio/features/customer/games/mood_tracker/domain/entities/mood_entry_entity.dart';
import 'package:Resilio/features/customer/games/game_hub/domain/repositories/games_repository.dart';

@LazySingleton(as: GamesRepository)
class GamesRepositoryImpl implements GamesRepository {
  final GamesRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  GamesRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, GameSessionEntity>> saveGameSession({
    required String gameType,
    required int durationSeconds,
    required int score,
    required String metadata,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final session = await _remoteDataSource.saveGameSession(
          gameType: gameType,
          durationSeconds: durationSeconds,
          score: score,
          metadata: metadata,
        );
        return Right(session);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, MoodEntryEntity>> saveMoodEntry({
    required int moodScore,
    required String moodLabel,
    required String note,
    required String entryDate,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final entry = await _remoteDataSource.saveMoodEntry(
          moodScore: moodScore,
          moodLabel: moodLabel,
          note: note,
          entryDate: entryDate,
        );
        return Right(entry);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<MoodEntryEntity>>> listMoodEntries({
    String? fromDate,
    String? toDate,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final entries = await _remoteDataSource.listMoodEntries(
          fromDate: fromDate,
          toDate: toDate,
        );
        return Right(entries);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<AchievementEntity>>> listUserAchievements() async {
    if (await _networkInfo.isConnected) {
      try {
        final achievements = await _remoteDataSource.listUserAchievements();
        return Right(achievements);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<AchievementEntity>>> listAllAchievements() async {
    if (await _networkInfo.isConnected) {
      try {
        final achievements = await _remoteDataSource.listAllAchievements();
        return Right(achievements);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, AffirmationEntity>> saveAffirmation({
    required String text,
    required String backgroundColor,
    required String iconName,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final affirmation = await _remoteDataSource.saveAffirmation(
          text: text,
          backgroundColor: backgroundColor,
          iconName: iconName,
        );
        return Right(affirmation);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<AffirmationEntity>>> listAffirmations() async {
    if (await _networkInfo.isConnected) {
      try {
        final affirmations = await _remoteDataSource.listAffirmations();
        return Right(affirmations);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAffirmation(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remoteDataSource.deleteAffirmation(id);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}

