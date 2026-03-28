import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/app_settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import 'settings_event.dart';
import 'settings_state.dart';

@lazySingleton
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc({required SettingsRepository repository})
      : _repository = repository,
        super(const SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateTheme>(_onUpdateTheme);
    on<UpdateLanguage>(_onUpdateLanguage);
    on<ToggleNotifications>(_onToggleNotifications);
    on<SetReminderTime>(_onSetReminderTime);
    on<ResetSettings>(_onResetSettings);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());

    final result = await _repository.getSettings();

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (settings) => emit(SettingsLoaded(settings)),
    );
  }

  Future<void> _onUpdateTheme(
    UpdateTheme event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SettingsLoaded) return;

    emit(const SettingsLoading());

    final result = await _repository.updateTheme(event.theme);

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) {
        final updated = currentState.settings.copyWith(theme: event.theme);
        emit(SettingsLoaded(updated));
      },
    );
  }

  Future<void> _onUpdateLanguage(
    UpdateLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SettingsLoaded) return;

    emit(const SettingsLoading());

    final result = await _repository.updateLanguage(event.language);

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) {
        final updated = currentState.settings.copyWith(language: event.language);
        emit(SettingsLoaded(updated));
      },
    );
  }

  Future<void> _onToggleNotifications(
    ToggleNotifications event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SettingsLoaded) return;

    final result = await _repository.toggleNotifications(event.enabled);

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) {
        final updated = currentState.settings.copyWith(
          notificationsEnabled: event.enabled,
        );
        emit(SettingsLoaded(updated));
      },
    );
  }

  Future<void> _onSetReminderTime(
    SetReminderTime event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SettingsLoaded) return;

    final result = await _repository.setReminderTime(event.time);

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) {
        final updated = currentState.settings.copyWith(
          reminderTime: event.time,
        );
        emit(SettingsLoaded(updated));
      },
    );
  }

  Future<void> _onResetSettings(
    ResetSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());

    final result = await _repository.resetToDefaults();

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) => emit(const SettingsLoaded(AppSettingsEntity())),
    );
  }
}
