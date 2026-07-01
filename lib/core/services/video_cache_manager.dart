import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Disk cache for reels/shorts video files.
///
/// Backs TikTok/Insta-style playback: a downloaded reel is served from disk on
/// replay and while offline. Bounded so the cache can't grow without limit —
/// [maxNrOfCacheObjects] + [stalePeriod] evict old reels (LRU) automatically.
class VideoCacheManager extends CacheManager {
  static const key = 'reelsVideoCache';

  static final VideoCacheManager _instance = VideoCacheManager._();
  factory VideoCacheManager() => _instance;

  VideoCacheManager._()
      : super(
          Config(
            key,
            // Keep offline copies for a month.
            stalePeriod: const Duration(days: 30),
            // Cap the number of cached reels to bound disk usage (~60 shorts).
            maxNrOfCacheObjects: 60,
          ),
        );
}
