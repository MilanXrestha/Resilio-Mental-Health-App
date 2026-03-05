import 'package:Resilio/core/routing/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../features/customer/audio/domain/entities/audio_entity.dart';
import '../../features/customer/auth/domain/usecases/send_otp_usecase.dart';
import '../../features/customer/auth/presentation/screens/login_screen.dart';
import '../../features/customer/auth/presentation/screens/passwordless_login_screen.dart';
import '../../features/customer/auth/presentation/screens/sign_up_screen.dart';
import '../../features/customer/audio/presentation/screens/media_player_screen.dart';
import '../../features/customer/video/domain/entities/video_entity.dart';
import '../../features/customer/video/presentation/screens/shorts_player_screen.dart';
import '../../features/customer/video/presentation/screens/long_video_player_screen.dart';
import '../../features/customer/main/presentation/screens/main_screen.dart';
import '../../features/customer/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/customer/preferences/presentation/screens/preferences_screen.dart';
import '../../features/customer/splash/presentation/screens/splash_screen.dart';
import '../di/injection.dart';
import 'navigation_service.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: getIt<NavigationService>().navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: RouteNames.register,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/preferences',
        name: RouteNames.preferences,
        builder: (context, state) {
          final fromProfile =
              state.uri.queryParameters['fromProfile'] == 'true';
          return PreferencesScreen(fromProfile: fromProfile);
        },
      ),
      GoRoute(
        path: '/home',
        name: RouteNames.home,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/passwordless-login',
        name: RouteNames.passwordlessLogin,
        builder: (context, state) => const PasswordlessLoginScreen(),
      ),
      GoRoute(
        path: '/media-player',
        name: RouteNames.mediaPlayer,
        builder: (context, state) {
          final audioTrack = state.extra as AudioEntity?;
          if (audioTrack == null) {
            return const SizedBox.shrink();
          }
          return MediaPlayerScreen(audioTrack: audioTrack);
        },
      ),
      GoRoute(
        path: '/shorts-player',
        name: RouteNames.shortsPlayer,
        builder: (context, state) {
          final videos = state.extra as List?;
          final index = state.uri.queryParameters['index'] != null 
            ? int.parse(state.uri.queryParameters['index']!) 
            : 0;
          if (videos == null || videos.isEmpty) {
            return const SizedBox.shrink();
          }
          // Cast to List<VideoEntity>
          final videoEntities = videos.cast<VideoEntity>();
          return ShortsPlayerScreen(videos: videoEntities, initialIndex: index);
        },
      ),
      GoRoute(
        path: '/long-video-player',
        name: RouteNames.longVideoPlayer,
        builder: (context, state) {
          final video = state.extra;
          if (video == null) {
            return const SizedBox.shrink();
          }
          // Cast to VideoEntity
          final videoEntity = video as VideoEntity;
          return LongVideoPlayerScreen(video: videoEntity);
        },
      ),
    ],
  );
}
