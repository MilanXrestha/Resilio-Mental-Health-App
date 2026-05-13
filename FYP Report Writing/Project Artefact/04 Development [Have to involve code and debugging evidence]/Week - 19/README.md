# Week 19 — Iteration 7 (cont.): Offline Sync, FCM Notifications, Subscriptions
**Phase:** Construction | **Dates:** 12–18 March 2025

---

## Features Built

| Feature | Layer | Status |
|---|---|---|
| SQLite offline mood logging (`sqflite`) | `core/database/` | Done |
| Offline-to-online background sync | `connectivity_plus` + sync job | Done |
| Protobuf serialisation for offline entries | `core/protos/` | Done |
| FCM push notifications (all event types) | `firebase_messaging` + `firebase-admin` | Done |
| Local notification display | `flutter_local_notifications` | Done |
| Subscription creation API | `subscription-routes.js` | Done |
| Flutter: Subscription plans screen (Free/Silver/Gold) | `customer/subscription/` | Done |
| Flutter: Settings and preferences screen | `customer/settings/` | Done |
| Construction phase final review | All 7 iterations complete | Done |

## Files to Place Here

- [ ] Screenshot — Offline mood log entry saved (airplane mode active)
- [ ] Screenshot — Sync icon showing pending offline entries
- [ ] Screenshot — Entries synced to server after reconnection (Supabase dashboard)
- [ ] Screenshot — FCM push notification received (appointment confirmation)
- [ ] Screenshot — Subscription plans screen
- [ ] Code snippet — Offline sync logic

## Code: Offline Mood Entry Sync

```dart
// core/database/sync_service.dart
Future<void> syncPendingEntries() async {
  final pending = await _localDb.getPendingMoodEntries();
  if (pending.isEmpty) return;

  for (final entry in pending) {
    try {
      await _moodRepository.createMoodEntry(entry);
      await _localDb.markAsSynced(entry.id);
    } catch (_) {
      // Will retry on next connectivity event
    }
  }
}

// Triggered on connectivity restore
_connectivity.onConnectivityChanged.listen((result) {
  if (result != ConnectivityResult.none) {
    syncPendingEntries();
  }
});
```

## Protobuf for Offline Serialisation

The `core/protos/` folder contains `.proto` definitions for offline data structures. Proto files are compiled with `protoc_plugin` to generate Dart classes.

```proto
// protos/mood_entry.proto
message MoodEntryOffline {
  string id = 1;
  string user_id = 2;
  int32 mood_score = 3;
  string mood_label = 4;
  string note = 5;
  int64 logged_at = 6;
  bool pending_sync = 7;
}
```

## Firebase Usage in Resilio

Note: Firebase is used for **multiple services** in this project:

| Firebase Service | Package | Purpose |
|---|---|---|
| Firebase Auth | `firebase_auth ^6.1.4` | Authentication (used alongside SuperTokens) |
| Cloud Firestore | `cloud_firestore ^6.1.2` | Real-time data synchronisation |
| Cloud Functions | `cloud_functions ^6.0.6` | Serverless backend functions |
| Firebase Messaging (FCM) | `firebase_messaging ^16.1.1` | Push notification delivery |

## Test Cases Passed

- TC-U026 — Notification created on appointment confirmation
- TC-U029 — Offline mood entry syncs on reconnection
- TC-U030 — Content served from cache when offline
- TC-S011 — Push notification delivered on appointment confirmation
- TC-UAT023 — Offline mood logging without confusion
