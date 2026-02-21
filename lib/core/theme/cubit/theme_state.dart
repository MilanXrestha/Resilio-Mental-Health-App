part of 'theme_cubit.dart';

/// State for ThemeCubit containing theme mode and locale
class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;

  const ThemeState({
    this.themeMode = ThemeMode.light,
    this.locale = const Locale('en'),
  });

  bool get isDarkMode => themeMode == ThemeMode.dark;
  bool get isEnglish => locale.languageCode == 'en';

  ThemeState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale];
}
