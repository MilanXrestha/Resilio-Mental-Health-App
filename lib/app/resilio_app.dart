import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/di/injection.dart';
import '../core/routing/app_router.dart';
import '../core/routing/route_names.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/cubit/theme_cubit.dart';
import '../core/services/push_notification_service.dart';

import '../l10n/app_localizations.dart';
import '../features/customer/auth/presentation/bloc/auth_bloc.dart';
import '../features/customer/auth/presentation/bloc/auth_state.dart';
import '../features/customer/favorites/presentation/bloc/favorite_bloc.dart';
import '../features/customer/favorites/presentation/bloc/favorite_event.dart';
import '../features/customer/subscription/presentation/bloc/subscription_bloc.dart';
import '../features/customer/subscription/presentation/bloc/subscription_event.dart';
import '../features/customer/games/game_hub/presentation/bloc/games_hub_cubit.dart';
import '../features/customer/profile/presentation/bloc/profile_bloc.dart';

/// The root widget of the Resilio application.
/// Configures theming, localization, routing using ThemeCubit.
class ResilioApp extends StatefulWidget {
  const ResilioApp({super.key});

  @override
  State<ResilioApp> createState() => _ResilioAppState();
}

class _ResilioAppState extends State<ResilioApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<ThemeCubit>()),
          BlocProvider(create: (_) => getIt<AuthBloc>()),
          BlocProvider(create: (_) => getIt<FavoriteBloc>()),
          BlocProvider(
            create: (context) =>
                getIt<SubscriptionBloc>()..add(LoadSubscription()),
          ),
          BlocProvider(
            create: (context) => getIt<GamesHubCubit>()..loadUserStats(),
          ),
          BlocProvider(
            create: (context) => getIt<ProfileBloc>()..add(LoadProfile()),
          ),
        ],
        child: _FavoriteAuthSync(
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
                supportedLocales: const [Locale('en'), Locale('ne')],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Loads favorites when session is restored and syncs on login/logout.
class _FavoriteAuthSync extends StatefulWidget {
  final Widget child;

  const _FavoriteAuthSync({required this.child});

  @override
  State<_FavoriteAuthSync> createState() => _FavoriteAuthSyncState();
}

class _FavoriteAuthSyncState extends State<_FavoriteAuthSync> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final auth = context.read<AuthBloc>().state;
      if (auth is AuthAuthenticated) {
        context.read<FavoriteBloc>().add(LoadFavorites(auth.user.id));
      }
    });

    // Wire up push notification handlers
    final pushService = PushNotificationService.instance;

    pushService.onTokenRefresh = (token) {};

    pushService.onNotificationTap = (actionType, payload) {
      final type = actionType?.toUpperCase();
      if (type == 'INCOMING_CALL' && payload != null) {
        // Patient taps the incoming call notification → join video session
        final appointmentId = payload['appointmentId'] as String?;
        final roomId = payload['roomId'] as String?;
        final userId = (payload['userId'] as String?) ?? '';
        if (appointmentId != null && appointmentId.isNotEmpty) {
          final room = (roomId != null && roomId.isNotEmpty) ? roomId : appointmentId;
          AppRouter.router.push('/video-call/$appointmentId/${userId.isNotEmpty ? userId : room}');
        }
      } else if (type == 'OPEN_APPOINTMENT' ||
          type == 'APPOINTMENT_CONFIRMED' ||
          type == 'APPOINTMENT_CANCELLED' ||
          type == 'APPOINTMENT_REMINDER') {
        // All appointment-related taps → customer's My Appointments screen
        AppRouter.router.push('/my-appointments');
      } else if (type == 'PAYMENT_CONFIRMED' || type == 'PAYMENT') {
        AppRouter.router.push('/subscription/transactions');
      } else {
        // Generic fallback → in-app notifications list
        AppRouter.router.push('/notifications');
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) {
        if (curr is AuthAuthenticated && prev is! AuthAuthenticated) return true;
        if (curr is AuthInitial && prev is! AuthInitial) return true;
        return false;
      },
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.read<FavoriteBloc>().add(LoadFavorites(state.user.id));
        } else if (state is AuthInitial) {
          context.read<FavoriteBloc>().add(const FavoriteReset());
          // Redirect the user to login screen after logout
          AppRouter.router.goNamed(RouteNames.login);
        }
      },
      child: widget.child,
    );
  }
}
