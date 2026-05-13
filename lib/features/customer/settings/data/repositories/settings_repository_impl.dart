import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../domain/entities/app_settings_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;

  SettingsRepositoryImpl({required SettingsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, AppSettingsEntity>> getSettings() async {
    try {
      final settings = await _localDataSource.getSettings();
      return Right(settings);
    } catch (e) {
      return Left(ServerFailure('Failed to load settings: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSettings(AppSettingsEntity settings) async {
    try {
      await _localDataSource.saveSettings(settings);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure('Failed to update settings: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTheme(AppTheme theme) async {
    try {
      final current = await _localDataSource.getSettings();
      final updated = current.copyWith(theme: theme);
      await _localDataSource.saveSettings(updated);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure('Failed to update theme: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateLanguage(AppLanguage language) async {
    try {
      final current = await _localDataSource.getSettings();
      final updated = current.copyWith(language: language);
      await _localDataSource.saveSettings(updated);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure('Failed to update language: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> toggleNotifications(bool enabled) async {
    try {
      final current = await _localDataSource.getSettings();
      final updated = current.copyWith(notificationsEnabled: enabled);
      await _localDataSource.saveSettings(updated);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure('Failed to toggle notifications: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> setReminderTime(String? time) async {
    try {
      final current = await _localDataSource.getSettings();
      final updated = current.copyWith(reminderTime: time);
      await _localDataSource.saveSettings(updated);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure('Failed to set reminder time: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetToDefaults() async {
    try {
      await _localDataSource.saveSettings(const AppSettingsEntity());
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure('Failed to reset settings: ${e.toString()}'));
    }
  }
}
