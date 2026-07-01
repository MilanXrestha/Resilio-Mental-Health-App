import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

enum MediaKind { audio, video }

/// Probes real media length from a URL when the DB duration is missing, so
/// content creators don't have to fill `duration_seconds` by hand.
///
/// Results are cached per-URL for the session. Probes are concurrency-capped
/// (a throwaway controller is created, its duration read, then disposed) so a
/// scrolling list can't spin up dozens of decoders at once (OOM guard).
class MediaDurationCache {
  MediaDurationCache._();

  static final Map<String, Duration?> _cache = {};

  static const int _maxConcurrent = 3;
  static int _active = 0;
  static final List<Completer<void>> _waiters = [];

  static Future<void> _acquire() async {
    if (_active < _maxConcurrent) {
      _active++;
      return;
    }
    final c = Completer<void>();
    _waiters.add(c);
    await c.future;
    _active++;
  }

  static void _release() {
    _active--;
    if (_waiters.isNotEmpty) _waiters.removeAt(0).complete();
  }

  /// Returns the media duration for [url], probing the file if not cached.
  /// Returns null if the URL is empty or probing fails.
  static Future<Duration?> resolve(String url, MediaKind kind) async {
    if (url.isEmpty) return null;
    if (_cache.containsKey(url)) return _cache[url];

    await _acquire();
    try {
      final duration = kind == MediaKind.audio
          ? await _probeAudio(url)
          : await _probeVideo(url);
      _cache[url] = duration;
      return duration;
    } catch (_) {
      _cache[url] = null;
      return null;
    } finally {
      _release();
    }
  }

  static Future<Duration?> _probeAudio(String url) async {
    final player = AudioPlayer();
    try {
      // setUrl reads just the header/metadata, not the whole file.
      return await player.setUrl(url);
    } finally {
      await player.dispose();
    }
  }

  static Future<Duration?> _probeVideo(String url) async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    try {
      await controller.initialize();
      return controller.value.duration;
    } finally {
      await controller.dispose();
    }
  }
}

/// Formats a duration as `m:ss`, or `h:mm:ss` once it passes an hour.
String formatMediaDuration(Duration d) {
  final hours = d.inHours;
  final minutes = d.inMinutes % 60;
  final seconds = d.inSeconds % 60;
  final ss = seconds.toString().padLeft(2, '0');
  if (hours > 0) {
    final mm = minutes.toString().padLeft(2, '0');
    return '$hours:$mm:$ss';
  }
  return '$minutes:$ss';
}
