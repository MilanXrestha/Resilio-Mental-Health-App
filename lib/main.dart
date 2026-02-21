import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/resilio_app.dart';
import 'core/di/injection.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureDependencies();
  runApp(const ResilioApp());
}
