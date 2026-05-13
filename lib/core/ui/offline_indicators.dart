import 'package:flutter/material.dart';
import 'package:Resilio/core/services/connectivity_monitor.dart';
import 'package:get_it/get_it.dart';

/// Extension for showing offline indicators in UI
extension OfflineIndicatorExtension on BuildContext {
  /// Stream of connectivity status for listening to changes
  Stream<bool> get isConnectedStream {
    final monitor = GetIt.I<ConnectivityMonitor>();
    return monitor.isConnectedStream;
  }

  /// Current connectivity status
  bool get isConnected {
    final monitor = GetIt.I<ConnectivityMonitor>();
    return monitor.isConnected;
  }

  /// Build offline banner when offline
  Widget buildOfflineIndicator({
    Color backgroundColor = const Color(0xFFFFA500),
    TextStyle? textStyle,
    VoidCallback? onDismiss,
  }) {
    return StreamBuilder<bool>(
      stream: isConnectedStream,
      initialData: isConnected,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return const SizedBox.shrink();
        }

        return Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You are offline - showing cached content',
                        style: textStyle ??
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (onDismiss != null)
                GestureDetector(
                  onTap: onDismiss,
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                )
            ],
          ),
        );
      },
    );
  }
}

/// Widget for showing offline banner
class OfflineBanner extends StatelessWidget {
  final Color backgroundColor;
  final TextStyle? textStyle;
  final VoidCallback? onDismiss;
  final bool dismissible;

  const OfflineBanner({
    super.key,
    this.backgroundColor = const Color(0xFFFFA500),
    this.textStyle,
    this.onDismiss,
    this.dismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    final monitor = GetIt.I<ConnectivityMonitor>();
    
    return StreamBuilder<bool>(
      stream: monitor.isConnectedStream,
      initialData: monitor.isConnected,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return const SizedBox.shrink();
        }

        return Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'You are offline - showing cached content',
                        style: textStyle ??
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (dismissible && onDismiss != null)
                GestureDetector(
                  onTap: onDismiss,
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                )
            ],
          ),
        );
      },
    );
  }
}

/// Dialog for showing sync in progress
class SyncInProgressDialog extends StatelessWidget {
  final String? message;
  final bool dismissible;

  const SyncInProgressDialog({
    super.key,
    this.message,
    this.dismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: dismissible,
      child: AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Expanded(
              child: Text(message ?? 'Syncing offline content...'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget for showing cache status
class CacheStatusWidget extends StatelessWidget {
  final String contentType;
  final DateTime? lastUpdated;
  final bool isShowingCached;

  const CacheStatusWidget({
    super.key,
    required this.contentType,
    this.lastUpdated,
    this.isShowingCached = false,
  });

  @override
  Widget build(BuildContext context) {
    final timeAgo = _getTimeAgoString(lastUpdated);
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (isShowingCached) ...[
            const Icon(Icons.cached, size: 14, color: Colors.orange),
            const SizedBox(width: 4),
          ],
          Expanded(
            child: Text(
              isShowingCached
                  ? 'Cached - last updated $timeAgo'
                  : 'Last updated $timeAgo',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isShowingCached ? Colors.orange : Colors.grey,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgoString(DateTime? time) {
    if (time == null) return 'never';
    
    final difference = DateTime.now().difference(time);
    
    if (difference.inMinutes < 1) return 'now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    
    return time.toString().split(' ')[0];
  }
}
