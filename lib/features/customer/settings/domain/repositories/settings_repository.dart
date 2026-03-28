import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/app_settings_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, AppSettingsEntity>> getSettings();
  Future<Either<Failure, Unit>> updateSettings(AppSettingsEntity settings);
  Future<Either<Failure, Unit>> updateTheme(AppTheme theme);
  Future<Either<Failure, Unit>> updateLanguage(AppLanguage language);
  Future<Either<Failure, Unit>> toggleNotifications(bool enabled);
  Future<Either<Failure, Unit>> setReminderTime(String? time);
  Future<Either<Failure, Unit>> resetToDefaults();
}
