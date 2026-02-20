import 'package:Resilio/core/routing/route_names.dart';
import 'package:go_router/go_router.dart';

import '../../features/customer/auth/presentation/screens/login_screen.dart';
import '../../features/customer/onboarding/presentation/screens/onboarding_screen.dart';
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
    ],
  );
}
