# Offline Support Implementation Guide

## Overview

This document explains the offline support system implemented for the Resilio customer side. The system automatically caches content locally and provides seamless fallback when the device is offline.

## Architecture

### 1. **Database Enhancement** (`core/database/database_helper.dart`)

The SQLite database has been enhanced with dedicated tables for different content types:

- **categories**: Cached category data
- **videos**: Cached video content (short and long form)
- **tips**: Cached wellness tips
- **affirmations**: Cached affirmations
- **quiz_questions**: Cached quiz questions
- **user_preferences**: User preference data
- **sync_metadata**: Tracks when each entity type was last synced

### 2. **Local Data Sources**

Each major content type now has a local data source for caching:

- `CategoryLocalDataSource` - Caches categories locally
- `VideoLocalDataSource` - Caches short and long-form videos
- `TipsLocalDataSource` - Caches wellness tips
- `AffirmationLocalDataSource` - Caches affirmations

### 3. **Repository Pattern with Caching**

Updated repositories implement a **network-first with fallback** strategy:

```
Try Network ➜ Cache locally ➜ Return data
    ↓
  Fail ➜ Try Cache ➜ Return cached data
    ↓
  Empty ➜ Return Error
```

Updated repositories:
- `CategoryRepositoryImpl`
- `VideoRepositoryImpl`
- `TipRepositoryImpl`

### 4. **Offline Services**

#### **OfflineSyncManager** (`core/services/offline_sync_manager.dart`)

Handles periodic syncing of cached content:

```dart
// Auto-sync when online (24-hour interval)
await offlineSyncManager.syncIfNeeded();

// Manual sync all content
await offlineSyncManager.syncAllContent();

// Check sync status
final status = offlineSyncManager.getSyncStatus();
```

#### **ConnectivityMonitor** (`core/services/connectivity_monitor.dart`)

Monitors network connectivity and triggers sync when device comes back online:

```dart
// Listen to connectivity changes
connectivityMonitor.isConnectedStream.listen((isOnline) {
  print('Online: $isOnline');
});

// Check current status
bool isOnline = connectivityMonitor.isConnected;
```

## Integration Steps

### Step 1: Update Dependency Injection

Register the new services in your `di/injectable.dart` or service locator setup:

```dart
// Already registered via @lazySingleton annotation on classes
// No additional setup needed if using injectable code generation
```

### Step 2: Initialize Connectivity Monitor in App Start

In your `main.dart` or app initialization:

```dart
import 'package:Resilio/core/services/connectivity_monitor.dart';

void main() {
  setupServiceLocator(); // your DI setup
  
  // Initialize connectivity monitoring
  final connectivityMonitor = getIt<ConnectivityMonitor>();
  connectivityMonitor.startMonitoring();
  
  runApp(const MyApp());
}
```

### Step 3: Use in UI/BLoCs

The caching happens automatically in repositories. No changes needed in UI code:

```dart
// This automatically uses cache if offline
final result = await categoriesRepository.getCategories();

result.fold(
  (failure) => print('Error: $failure'),
  (categories) => print('Got ${categories.length} categories'),
);
```

### Step 4: Sync Content Periodically (Optional)

In your app shell or home screen, trigger periodic sync:

```dart
final syncManager = getIt<OfflineSyncManager>();

// On app startup or when user navigates to home
await syncManager.syncIfNeeded();

// Or manually trigger full sync
await syncManager.syncAllContent();
```

## Features

### ✅ Automatic Caching
- Content is automatically cached when fetched online
- No code changes needed in existing code

### ✅ Offline Fallback
- When offline, cached data is automatically served
- Users see cached content instead of errors

### ✅ Smart Sync
- Sync triggered when device comes back online
- Automatic periodic sync (24-hour interval)
- Sync doesn't block UI (happens in background)

### ✅ Network-First Strategy
- Always tries fresh data from network when online
- Falls back to cache only if network fails

### ✅ Content Types Supported
- Categories
- Videos (short and long form)
- Tips and Wellness Content
- Affirmations
- Quiz Questions
- User Preferences

## Cache Validity Times

Default cache validity periods:

```dart
// 60 minutes (general content)
DatabaseHelper.cacheValidityDefault

// 30 minutes (short-form content like videos)
DatabaseHelper.cacheValidityShortContent  

// 120 minutes (user data like preferences)
DatabaseHelper.cacheValidityUserData
```

## Database Schema

### Categories Table
```sql
CREATE TABLE categories (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  imageUrl TEXT,
  data TEXT NOT NULL,
  timestamp INTEGER NOT NULL
)
```

### Videos Table
```sql
CREATE TABLE videos (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  categoryId TEXT,
  duration INTEGER,
  thumbnailUrl TEXT,
  videoUrl TEXT,
  type TEXT,
  isFeatured INTEGER,
  data TEXT NOT NULL,
  timestamp INTEGER NOT NULL
)
```

### Tips Table
```sql
CREATE TABLE tips (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  categoryId TEXT,
  imageUrl TEXT,
  data TEXT NOT NULL,
  timestamp INTEGER NOT NULL
)
```

## Usage Examples

### Example 1: Display Cached Categories

```dart
final categoriesRepository = getIt<CategoryRepository>();

// This will return categories from network if online,
// or from cache if offline
final result = await categoriesRepository.getCategories();

result.fold(
  (failure) {
    // Show error with offline indicator
    print('Offline - showing cached data');
  },
  (categories) {
    // Display categories
    print('Showing ${categories.length} categories');
  },
);
```

### Example 2: Monitor Connectivity

```dart
final connectivityMonitor = getIt<ConnectivityMonitor>();

// Listen to changes
connectivityMonitor.isConnectedStream.listen((isOnline) {
  if (isOnline) {
    print('Back online - triggering sync');
    // Trigger content refresh
  } else {
    print('Offline - using cached content');
  }
});
```

### Example 3: Manual Sync

```dart
final syncManager = getIt<OfflineSyncManager>();

// In a button or on-demand sync
bool success = await syncManager.syncAllContent();

if (success) {
  print('Content synced successfully');
} else {
  print('Sync failed or no internet');
}

// Check status
final status = syncManager.getSyncStatus();
print('Last sync: ${status['lastSyncTime']}');
```

## Best Practices

1. **Always use repositories** - Don't access data sources directly
2. **Handle offline gracefully** - Use `fold()` pattern to handle failures
3. **Show indicators** - Display "Offline" indicators to users when showing cached data
4. **Periodically sync** - Call `syncIfNeeded()` on app startup and in idle states
5. **Cache management** - Monitor cache size for storage constraints

## Future Enhancements

1. **Selective offline content** - Let users download specific content for offline
2. **Push update notifications** - Notify users when cached content is updated
3. **Cache size management** - Implement cache size limits and cleanup
4. **Offline indicators** - Visual indicators for cached vs fresh data
5. **Sync status UI** - Show sync progress in app

## Files Modified/Created

### Modified:
- `lib/core/database/database_helper.dart` - Enhanced with new tables and methods
- `lib/features/customer/categories/data/repositories/category_repository_impl.dart`
- `lib/features/customer/video/data/repositories/video_repository_impl.dart`
- `lib/features/customer/tips/data/repositories/tip_repository_impl.dart`

### Created:
- `lib/core/database/database_helper.dart` - Enhanced version
- `lib/features/customer/categories/data/datasources/local/category_local_data_source.dart`
- `lib/features/customer/video/data/datasources/local/video_local_data_source.dart`
- `lib/features/customer/tips/data/datasources/local/tips_local_data_source.dart`
- `lib/features/customer/games/affirmation_builder/data/datasources/local/affirmation_local_data_source.dart`
- `lib/core/services/offline_sync_manager.dart`
- `lib/core/services/connectivity_monitor.dart`

## Troubleshooting

### Issue: Old cached data is showing
**Solution**: Implement user-triggered refresh or increase sync frequency

### Issue: Large database size
**Solution**: Implement cache cleanup for old entries (timestamp-based)

### Issue: Sync not happening
**Solution**: Check `OfflineSyncManager.getSyncStatus()` and verify connectivity monitor is started

## Support

For questions or issues with offline support, refer to the architecture documentation or create an issue in the project repository.
