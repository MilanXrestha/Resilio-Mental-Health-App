import 'package:flutter/material.dart';

import '../services/media_duration_cache.dart';

/// Resolves a media duration label and hands it to [builder].
///
/// Uses [fallbackSeconds] (the DB value) when it's > 0; otherwise probes the
/// real media length from [url] via [MediaDurationCache]. The builder receives
/// the formatted label (e.g. `3:45`) or null while unknown, so callers keep
/// full control of the chip's styling.
class MediaDurationResolver extends StatefulWidget {
  final String url;
  final int fallbackSeconds;
  final MediaKind kind;
  final Widget Function(BuildContext context, String? label) builder;

  const MediaDurationResolver({
    super.key,
    required this.url,
    required this.fallbackSeconds,
    required this.kind,
    required this.builder,
  });

  @override
  State<MediaDurationResolver> createState() => _MediaDurationResolverState();
}

class _MediaDurationResolverState extends State<MediaDurationResolver> {
  String? _label;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant MediaDurationResolver oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url ||
        oldWidget.fallbackSeconds != widget.fallbackSeconds) {
      _init();
    }
  }

  void _init() {
    if (widget.fallbackSeconds > 0) {
      _label = formatMediaDuration(Duration(seconds: widget.fallbackSeconds));
      return;
    }
    _label = null;
    MediaDurationCache.resolve(widget.url, widget.kind).then((d) {
      if (!mounted || d == null) return;
      setState(() => _label = formatMediaDuration(d));
    });
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _label);
}
