import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/resilio_app.dart';
import 'core/di/injection.dart';
import 'core/services/auth_token_service.dart';
import 'core/services/push_notification_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies();

  // Initializing Push Notifications (singleton — use .instance everywhere)
  await PushNotificationService.instance.initialize();

  // Initialize auth token service to load persisted tokens
  final authTokenService = getIt<AuthTokenService>();
  await authTokenService.init();

  runApp(const ResilioApp());
}
