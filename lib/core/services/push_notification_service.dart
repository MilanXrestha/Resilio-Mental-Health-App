import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}

/// Singleton push notification service.
/// Access via [PushNotificationService.instance] everywhere in the app.
class PushNotificationService {
  PushNotificationService._internal();

  static final PushNotificationService instance =
      PushNotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  /// Called when the user taps a notification.
  /// Receives the action type (e.g. 'OPEN_APPOINTMENT') and payload map.
  /// Wire this up in your router/navigator to navigate to the right screen.
  void Function(String? actionType, Map<String, dynamic>? payload)?
      onNotificationTap;

  /// Called when the FCM token is refreshed.
  /// Use this to call PUT /api/v1/users/me/fcm-token on backend.
  void Function(String newToken)? onTokenRefresh;

  Future<void> initialize() async {
    // Request permission (Apple & Web)
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications for foreground push on Android
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await _localNotifications.initialize(
      settings: initSettings,
      // Called when user taps a local notification (foreground/background)
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('Notification tapped — payload: ${response.payload}');
        _handlePayloadTap(response.payload);
      },
      // Called when app is in the background and taps the notification
      onDidReceiveBackgroundNotificationResponse:
          _onBackgroundNotificationResponse,
    );

    // Top-level background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Foreground messages: show as a local notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground FCM message received: ${message.data}');
      if (message.notification != null) {
        _showLocalNotification(
          message.notification!,
          data: message.data,
        );
      }
    });

    // Background → app opened via notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Notification opened app from background: ${message.data}');
      onNotificationTap?.call(
        message.data['action']?.toString(),
        message.data,
      );
    });

    // Terminated → app cold-started via notification tap
    final initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('App launched from notification: ${initialMessage.data}');
      // Small delay so routing is ready before navigating
      Future.delayed(const Duration(milliseconds: 500), () {
        onNotificationTap?.call(
          initialMessage.data['action']?.toString(),
          initialMessage.data,
        );
      });
    }

    // 🔄 Token refresh listener — keep backend token in sync
    _fcm.onTokenRefresh.listen((newToken) {
      debugPrint('FCM token refreshed');
      onTokenRefresh?.call(newToken);
    });
  }

  void _handlePayloadTap(String? payload) {
    if (payload == null || onNotificationTap == null) return;
    // Payload format: "ACTION_TYPE|key=value&key2=value2"
    final parts = payload.split('|');
    final actionType = parts.isNotEmpty ? parts[0] : null;
    Map<String, dynamic>? payloadMap;
    if (parts.length > 1) {
      try {
        payloadMap = Map<String, dynamic>.from(Uri.splitQueryString(parts[1]));
      } catch (_) {}
    }
    onNotificationTap?.call(actionType, payloadMap);
  }

  Future<void> _showLocalNotification(
    RemoteNotification notification, {
    Map<String, dynamic>? data,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'resilio_main_channel',
      'Resilio General Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    // Encode action + payload into the tap payload string
    String? payloadStr;
    if (data != null && data['action'] != null) {
      final encoded = data.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
          .join('&');
      payloadStr = '${data['action']}|$encoded';
    }

    // Use positive notification ID — hashCode can be negative which crashes on Android
    final notifId = notification.hashCode.abs();

    await _localNotifications.show(
      id: notifId,
      title: notification.title,
      body: notification.body,
      notificationDetails: details,
      payload: payloadStr,
    );
  }

  /// Get the device FCM token to send to backend on login/sync
  Future<String?> getToken() async {
    try {
      return await _fcm.getToken();
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }
}

/// Top-level background notification response handler (must be a top-level function).
@pragma('vm:entry-point')
void _onBackgroundNotificationResponse(NotificationResponse response) {
  // Background taps are handled by FirebaseMessaging.onMessageOpenedApp
  // This is a no-op placeholder required by flutter_local_notifications v20+
  debugPrint('Background notification tapped: ${response.payload}');
}
