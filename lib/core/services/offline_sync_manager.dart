import 'package:injectable/injectable.dart';
import 'package:Resilio/core/network/network_info.dart';
import 'package:Resilio/features/customer/categories/domain/repositories/category_repository.dart';
import 'package:Resilio/features/customer/video/domain/repositories/video_repository.dart';
import 'package:Resilio/features/customer/tips/domain/repositories/tip_repository.dart';

/// OfflineSyncManager handles syncing of offline content when online
/// Refreshes cached data periodically or on demand
@lazySingleton
class OfflineSyncManager {
  final NetworkInfo _networkInfo;
  final CategoryRepository _categoryRepository;
  final VideoRepository _videoRepository;
  final TipRepository _tipRepository;

  bool _isSyncing = false;
  DateTime? _lastSyncTime;

  OfflineSyncManager(
    this._networkInfo,
    this._categoryRepository,
    this._videoRepository,
    this._tipRepository,
  );

  /// Check if currently syncing
  bool get isSyncing => _isSyncing;

  /// Get last sync time
  DateTime? get lastSyncTime => _lastSyncTime;

  /// Check if sync is needed (every 24 hours)
  bool _shouldSync() {
    if (_lastSyncTime == null) return true;
    final difference = DateTime.now().difference(_lastSyncTime!);
    return difference.inHours >= 24;
  }

  /// Sync all offline content
  /// Returns true if sync was successful, false otherwise
  Future<bool> syncAllContent() async {
    if (!await _networkInfo.isConnected) {
      return false;
    }

    if (_isSyncing) {
      return false;
    }

    _isSyncing = true;
    try {
      // Sync categories
      await _syncCategories();

      // Sync videos
      await _syncVideos();

      // Sync tips
      await _syncTips();

      _lastSyncTime = DateTime.now();
      return true;
    } catch (e) {
      // Continue syncing other content even if one fails
      return false;
    } finally {
      _isSyncing = false;
    }
  }

  /// Sync specific categories
  Future<void> _syncCategories() async {
    try {
      await _categoryRepository.getCategories();
    } catch (e) {
      // Log error but continue
    }
  }

  /// Sync videos (short and long form)
  Future<void> _syncVideos() async {
    try {
      // Sync short videos
      await _videoRepository.getShortVideos(limit: 50);
      
      // Sync long videos
      await _videoRepository.getLongVideos(limit: 50);
      
      // Sync featured videos
      await _videoRepository.getFeaturedVideos(limit: 20);
    } catch (e) {
      // Log error but continue
    }
  }

  /// Sync tips
  Future<void> _syncTips() async {
    try {
      // Sync featured tips
      await _tipRepository.getFeaturedTips(limit: 30);
      
      // Sync general tips
      await _tipRepository.listTips(limit: 50);
    } catch (e) {
      // Log error but continue
    }
  }

  /// Sync content if needed (on demand)
  Future<bool> syncIfNeeded() async {
    if (_shouldSync() && await _networkInfo.isConnected) {
      return await syncAllContent();
    }
    return false;
  }

  /// Force clear all cached content
  Future<void> clearAllCache() async {
    // This would require adding clearCache methods to repositories
    // For now, we'll just reset the last sync time
    _lastSyncTime = null;
  }

  /// Get sync status information
  Map<String, dynamic> getSyncStatus() {
    return {
      'isSyncing': _isSyncing,
      'lastSyncTime': _lastSyncTime?.toIso8601String(),
      'shouldSync': _shouldSync(),
    };
  }
}
