import 'package:flutter/material.dart';
import 'app/resilio_app.dart';
import 'core/di/injection.dart';
import 'core/settings/app_settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final appSettings = AppSettings();
  await appSettings.load();
  runApp(ResilioApp(appSettings: appSettings));
}
