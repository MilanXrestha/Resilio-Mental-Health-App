import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  Future<bool> isOnboardingCompleted();
  Future<void> markOnboardingCompleted();
  Future<void> resetOnboardingStatus();
}

@LazySingleton(as: OnboardingLocalDataSource)
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  static const _keyOnboardingCompleted = 'onboarding_completed';

  final SharedPreferences _prefs;

  OnboardingLocalDataSourceImpl(this._prefs);

  @override
  Future<bool> isOnboardingCompleted() async {
    return _prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  @override
  Future<void> markOnboardingCompleted() async {
    await _prefs.setBool(_keyOnboardingCompleted, true);
  }

  @override
  Future<void> resetOnboardingStatus() async {
    await _prefs.remove(_keyOnboardingCompleted);
  }
}
