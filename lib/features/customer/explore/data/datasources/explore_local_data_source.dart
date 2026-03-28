import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExploreLocalDataSource {
  Future<List<String>> getRecentSearches();
  Future<void> saveRecentSearch(String query);
  Future<void> clearRecentSearches();
  List<String> getTrendingSearches();
}

@LazySingleton(as: ExploreLocalDataSource)
class ExploreLocalDataSourceImpl implements ExploreLocalDataSource {
  final SharedPreferences _prefs;

  static const String _recentSearchesKey = 'explore_recent_searches';
  static const int _maxRecentSearches = 10;

  ExploreLocalDataSourceImpl(this._prefs);

  @override
  Future<List<String>> getRecentSearches() async {
    final searches = _prefs.getStringList(_recentSearchesKey);
    return searches ?? [];
  }

  @override
  Future<void> saveRecentSearch(String query) async {
    final searches = await getRecentSearches();

    // Remove if already exists (to move to front)
    searches.remove(query);

    // Add to front
    searches.insert(0, query);

    // Keep only max number of searches
    final trimmedSearches = searches.take(_maxRecentSearches).toList();

    await _prefs.setStringList(_recentSearchesKey, trimmedSearches);
  }

  @override
  Future<void> clearRecentSearches() async {
    await _prefs.remove(_recentSearchesKey);
  }

  @override
  List<String> getTrendingSearches() {
    // Static trending searches - could be fetched from backend in future
    return [
      'Meditation',
      'Sleep',
      'Anxiety',
      'Focus',
      'Relaxation',
      'Mindfulness',
      'Stress Relief',
      'Morning Routine',
    ];
  }
}