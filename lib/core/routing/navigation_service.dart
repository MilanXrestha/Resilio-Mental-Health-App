import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext getContext() {
    final context = navigatorKey.currentContext;
    if (context == null) {
      throw Exception('Navigator context is null. Ensure the navigatorKey is attached to the MaterialApp.');
    }
    return context;
  }
}
