import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resilio/core/di/injection.dart';
import 'package:resilio/core/routing/app_router.dart';
import 'package:resilio/core/settings/app_settings.dart';
import 'package:resilio/core/settings/app_settings_scope.dart';
import 'package:resilio/core/theme/app_theme.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final appSettings = AppSettings();
  await appSettings.load();
  runApp(ResilioApp(appSettings: appSettings));
}

class ResilioApp extends StatefulWidget {
  const ResilioApp({super.key, required this.appSettings});

  final AppSettings appSettings;

  @override
  State<ResilioApp> createState() => _ResilioAppState();
}

class _ResilioAppState extends State<ResilioApp> {
  @override
  void initState() {
    super.initState();
    widget.appSettings.addListener(_onSettingsChanged);
  }

  @override
  void didUpdateWidget(covariant ResilioApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.appSettings != widget.appSettings) {
      oldWidget.appSettings.removeListener(_onSettingsChanged);
      widget.appSettings.addListener(_onSettingsChanged);
    }
  }

  @override
  void dispose() {
    widget.appSettings.removeListener(_onSettingsChanged);
    super.dispose();
  }

  void _onSettingsChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final settings = widget.appSettings;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) => AppSettingsScope(
        notifier: settings,
        child: MaterialApp.router(
          title: 'Resilio',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: settings.themeMode,
          locale: settings.locale,
          routerConfig: AppRouter.router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ne'),
          ],
        ),
      ),
    );
  }
}
