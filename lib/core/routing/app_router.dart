import 'package:Resilio/core/routing/route_names.dart';
import 'package:go_router/go_router.dart';

import '../../features/customer/auth/domain/usecases/send_otp_usecase.dart';
import '../../features/customer/auth/presentation/screens/login_screen.dart';
import '../../features/customer/auth/presentation/screens/passwordless_login_screen.dart';
import '../../features/customer/auth/presentation/screens/sign_up_screen.dart';
import '../../features/customer/home/presentation/screens/home_screen.dart';
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
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/passwordless-login',
        name: RouteNames.passwordlessLogin,
        builder: (context, state) => const PasswordlessLoginScreen(),
      ),
    ],
  );
}
