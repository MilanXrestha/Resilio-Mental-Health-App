import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/di/injection.dart';
import '../core/routing/app_router.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/cubit/theme_cubit.dart';
import '../features/customer/auth/data/datasources/remote/firebase_auth_data_source.dart';
import '../l10n/app_localizations.dart';

/// The root widget of the Resilio application.
/// Configures theming, localization, routing using ThemeCubit.
class ResilioApp extends StatefulWidget {
  const ResilioApp({super.key});

  @override
  State<ResilioApp> createState() => _ResilioAppState();
}

class _ResilioAppState extends State<ResilioApp> {
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _initDeepLinkHandling();
  }

  Future<void> _initDeepLinkHandling() async {
    // Handle initial link (app opened from email link)
    try {
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        await _handleEmailLink(initialLink.toString());
      }
    } catch (e) {
      debugPrint('Error getting initial link: $e');
    }

    // Listen for incoming links while app is running
    _appLinks.uriLinkStream.listen((Uri? uri) async {
      if (uri != null) {
        await _handleEmailLink(uri.toString());
      }
    }, onError: (err) {
      debugPrint('Error listening to link stream: $err');
    });
  }

  Future<void> _handleEmailLink(String link) async {
    try {
      final authDataSource = getIt<FirebaseAuthDataSource>();
      if (authDataSource.isSignInWithEmailLink(link)) {
        final result = await authDataSource.handleIncomingEmailLink(link);
        if (result != null) {
          debugPrint('Successfully signed in with email link!');
          // Navigation to home will be handled by auth state listener
        }
      }
    } catch (e) {
      debugPrint('Error handling email link: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) => BlocProvider(
        create: (_) => getIt<ThemeCubit>(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'Resilio',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: state.themeMode,
              locale: state.locale,
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
            );
          },
        ),
      ),
    );
  }
}
