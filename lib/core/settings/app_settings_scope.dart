import 'package:flutter/material.dart';

import 'app_settings.dart';

/// Provides [AppSettings] to the widget tree.
class AppSettingsScope extends InheritedNotifier<AppSettings> {
  const AppSettingsScope({
    super.key,
    required AppSettings notifier,
    required super.child,
  }) : super(notifier: notifier);

  static AppSettings of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppSettingsScope>();
    assert(scope != null, 'AppSettingsScope not found in context');
    return scope!.notifier!;
  }
}
