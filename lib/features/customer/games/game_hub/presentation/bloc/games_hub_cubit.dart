import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/games_repository.dart';

class GamesHubState extends Equatable {
  final int achievements;
  final int gamesPlayed;
  final int points;
  final bool isLoading;
  final String? error;

  const GamesHubState({
    this.achievements = 0,
    this.gamesPlayed = 0,
    this.points = 0,
    this.isLoading = false,
    this.error,
  });

  GamesHubState copyWith({
    int? achievements,
    int? gamesPlayed,
    int? points,
    bool? isLoading,
    String? error,
  }) {
    return GamesHubState(
      achievements: achievements ?? this.achievements,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      points: points ?? this.points,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [achievements, gamesPlayed, points, isLoading, error];
}

@injectable
class GamesHubCubit extends Cubit<GamesHubState> {
  final GamesRepository _repository;

  GamesHubCubit(this._repository) : super(const GamesHubState());

  static const _kAch = 'hub_achievements';
  static const _kGames = 'hub_games_played';
  static const _kPts = 'hub_points';

  Future<void> loadUserStats() async {
    // 1. Show cached stats instantly (no shimmer) if we have them.
    final prefs = await SharedPreferences.getInstance();
    final hasCache = prefs.containsKey(_kPts);
    if (hasCache) {
      emit(state.copyWith(
        isLoading: false,
        error: null,
        achievements: prefs.getInt(_kAch) ?? 0,
        gamesPlayed: prefs.getInt(_kGames) ?? 0,
        points: prefs.getInt(_kPts) ?? 0,
      ));
    } else {
      emit(state.copyWith(isLoading: true, error: null));
    }

    // 2. Refresh in the background and update + re-cache.
    final achievementsResult = await _repository.listUserAchievements();
    final sessionsResult = await _repository.listGameSessions();

    achievementsResult.fold(
      (failure) {
        // Keep showing cached values on failure; only surface error if empty.
        if (!hasCache) {
          emit(state.copyWith(isLoading: false, error: failure.message));
        }
      },
      (achievements) {
        final unlockedCount = achievements.length;
        int sessionCount = 0;
        sessionsResult.fold((_) {}, (count) {
          sessionCount = count;
        });
        // Points: each achievement = 50 pts, each game session = 10 pts
        final pts = (unlockedCount * 50) + (sessionCount * 10);
        prefs.setInt(_kAch, unlockedCount);
        prefs.setInt(_kGames, sessionCount);
        prefs.setInt(_kPts, pts);
        emit(state.copyWith(
          isLoading: false,
          achievements: unlockedCount,
          points: pts,
          gamesPlayed: sessionCount,
        ));
      },
    );
  }
}
