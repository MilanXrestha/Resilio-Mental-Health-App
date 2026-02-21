import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:Resilio/core/errors/failures.dart';
import 'package:Resilio/core/usecases/usecase.dart';
import '../../domain/usecases/check_preferences_completion_usecase.dart';
import '../../domain/usecases/get_preferences_usecase.dart';
import '../../domain/usecases/get_user_preferences_usecase.dart';
import '../../domain/usecases/save_user_preferences_usecase.dart';
import 'preferences_event.dart';
import 'preferences_state.dart';

@injectable
class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final GetPreferencesUseCase _getPreferencesUseCase;
  final GetUserPreferencesUseCase _getUserPreferencesUseCase;
  final SaveUserPreferencesUseCase _saveUserPreferencesUseCase;
  final CheckPreferencesCompletionUseCase _checkCompletionUseCase;

  PreferencesBloc(
    this._getPreferencesUseCase,
    this._getUserPreferencesUseCase,
    this._saveUserPreferencesUseCase,
    this._checkCompletionUseCase,
  ) : super(const PreferencesInitial()) {
    on<LoadPreferencesEvent>(_onLoadPreferences);
    on<LoadUserPreferencesEvent>(_onLoadUserPreferences);
    on<TogglePreferenceEvent>(_onTogglePreference);
    on<SavePreferencesEvent>(_onSavePreferences);
    on<CheckPreferencesCompletionEvent>(_onCheckCompletion);
  }

  Future<void> _onLoadPreferences(
    LoadPreferencesEvent event,
    Emitter<PreferencesState> emit,
  ) async {
    emit(const PreferencesLoading());

    final result = await _getPreferencesUseCase(const NoParams());

    result.fold(
      (failure) => emit(PreferencesError(failure.message)),
      (preferences) => emit(PreferencesLoaded(preferences: preferences)),
    );
  }

  Future<void> _onLoadUserPreferences(
    LoadUserPreferencesEvent event,
    Emitter<PreferencesState> emit,
  ) async {
    emit(const PreferencesLoading());

    try {
      // Load all preferences and user preferences with timeout handling
      final preferencesResult = await _loadWithTimeout(_getPreferencesUseCase(const NoParams()), 'loading preferences');
      final userPrefsResult = await _loadWithTimeout(_getUserPreferencesUseCase(const NoParams()), 'loading user preferences');
      final completionResult = await _loadWithTimeout(_checkCompletionUseCase(const NoParams()), 'checking preferences completion');

      preferencesResult.fold(
        (failure) {
          // If main preferences fail, emit error but provide fallback empty list
          emit(PreferencesError(failure.message));
        },
        (preferences) {
          final selectedIds = userPrefsResult.fold(
            (failure) {
              // Log the error but continue with empty selection
              debugPrint('Warning: Failed to load user preferences: ${failure.message}');
              return <String>[]; // Default to empty if user prefs fail
            },
            (userPrefs) => userPrefs.map((p) => p.preference.id).toList(),
          );

          final hasCompleted = completionResult.fold(
            (failure) {
              // Log the error but continue with default value
              debugPrint('Warning: Failed to check preferences completion: ${failure.message}');
              return false; // Default to false if completion check fails
            },
            (completed) => completed,
          );

          emit(PreferencesLoaded(
            preferences: preferences,
            selectedPreferenceIds: selectedIds,
            hasCompletedPreferences: hasCompleted,
          ));
        },
      );
    } catch (e) {
      emit(PreferencesError('Failed to load preferences: $e'));
    }
  }
  
  /// Helper method to load data with timeout
  Future<Either<Failure, T>> _loadWithTimeout<T>(Future<Either<Failure, T>> future, String operation) async {
    try {
      return await future.timeout(
        const Duration(seconds: 10),
        onTimeout: () => Left(ServerFailure('Timeout $operation')),
      );
    } catch (e) {
      return Left(ServerFailure('Error $operation: $e'));
    }
  }

  Future<void> _onTogglePreference(
    TogglePreferenceEvent event,
    Emitter<PreferencesState> emit,
  ) async {
    if (state is PreferencesLoaded) {
      final currentState = state as PreferencesLoaded;
      final selectedIds = List<String>.from(currentState.selectedPreferenceIds);

      if (selectedIds.contains(event.preferenceId)) {
        selectedIds.remove(event.preferenceId);
      } else {
        selectedIds.add(event.preferenceId);
      }

      emit(currentState.copyWith(selectedPreferenceIds: selectedIds));
    }
  }

  Future<void> _onSavePreferences(
    SavePreferencesEvent event,
    Emitter<PreferencesState> emit,
  ) async {
    if (state is PreferencesLoaded) {
      final currentState = state as PreferencesLoaded;
      
      if (currentState.selectedPreferenceIds.isEmpty) {
        emit(const PreferencesError('Please select at least one preference'));
        emit(currentState); // Re-emit current state to keep UI
        return;
      }

      emit(const PreferencesLoading());

      final result = await _saveUserPreferencesUseCase(
        SaveUserPreferencesParams(preferenceIds: currentState.selectedPreferenceIds),
      );

      result.fold(
        (failure) => emit(PreferencesError(failure.message)),
        (_) => emit(const PreferencesSaved()),
      );
    }
  }

  Future<void> _onCheckCompletion(
    CheckPreferencesCompletionEvent event,
    Emitter<PreferencesState> emit,
  ) async {
    final result = await _checkCompletionUseCase(const NoParams());

    result.fold(
      (failure) {}, // Silently fail
      (completed) {
        if (state is PreferencesLoaded) {
          final currentState = state as PreferencesLoaded;
          emit(currentState.copyWith(hasCompletedPreferences: completed));
        }
      },
    );
  }
}
