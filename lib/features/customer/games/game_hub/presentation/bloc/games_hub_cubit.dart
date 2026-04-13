import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

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

  Future<void> loadUserStats() async {
    emit(state.copyWith(isLoading: true, error: null));

    // Load achievements and game sessions in parallel
    final achievementsResult = await _repository.listUserAchievements();
    final sessionsResult = await _repository.listGameSessions();

    achievementsResult.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (achievements) {
        final unlockedCount = achievements.length;
        int sessionCount = 0;
        sessionsResult.fold((_) {}, (count) {
          sessionCount = count;
        });
        // Points: each achievement = 50 pts, each game session = 10 pts
        final pts = (unlockedCount * 50) + (sessionCount * 10);
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
