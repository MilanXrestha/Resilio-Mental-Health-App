import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'offline_sync_manager.dart';

/// Monitors network connectivity changes and triggers offline content sync
@lazySingleton
class ConnectivityMonitor {
  final Connectivity _connectivity;
  final OfflineSyncManager _offlineSyncManager;

  late BehaviorSubject<bool> _isConnectedSubject;
  bool _wasOffline = false;

  ConnectivityMonitor(
    this._connectivity,
    this._offlineSyncManager,
  ) {
    _isConnectedSubject = BehaviorSubject<bool>(onListen: _checkConnectivity);
  }

  /// Stream of connectivity status changes
  Stream<bool> get isConnectedStream => _isConnectedSubject.stream;

  /// Current connectivity status
  bool get isConnected => _isConnectedSubject.value;

  /// Initialize monitoring
  void startMonitoring() {
    _checkConnectivity();
    
    _connectivity.onConnectivityChanged.listen((result) {
      final isOnline = result != ConnectivityResult.none;
      _isConnectedSubject.add(isOnline);
      
      // Trigger sync when coming back online
      if (isOnline && _wasOffline) {
        _wasOffline = false;
        _triggerOfflineSyncIfNeeded();
      } else if (!isOnline) {
        _wasOffline = true;
      }
    });
  }

  /// Check current connectivity status
  Future<void> _checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      final isOnline = result != ConnectivityResult.none;
      _isConnectedSubject.add(isOnline);
    } catch (e) {
      // Default to offline if check fails
      _isConnectedSubject.add(false);
    }
  }

  /// Trigger offline sync when device comes back online
  Future<void> _triggerOfflineSyncIfNeeded() async {
    try {
      // Small delay to ensure network is stable
      await Future.delayed(const Duration(seconds: 1));
      await _offlineSyncManager.syncIfNeeded();
    } catch (e) {
      // Log error silently
    }
  }

  /// Dispose resources
  void dispose() {
    _isConnectedSubject.close();
  }
}
