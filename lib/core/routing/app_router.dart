import 'package:go_router/go_router.dart';

import 'package:resilio/core/di/injection.dart';
import 'package:resilio/core/routing/navigation_service.dart';
import 'package:resilio/core/routing/route_names.dart';
import 'package:resilio/core/usecases/usecase.dart';
import 'package:resilio/features/customer/auth/presentation/screens/login_screen.dart';
import 'package:resilio/features/customer/onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import 'package:resilio/features/customer/onboarding/presentation/screens/onboarding_screen.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: getIt<NavigationService>().navigatorKey,
    initialLocation: '/',
    redirect: (context, state) async {
      final checkOnboardingStatus = getIt<CheckOnboardingStatusUseCase>();
      final result = await checkOnboardingStatus.call(const NoParams());
      final onboardingCompleted = result.getOrElse(() => false);
      final path = state.matchedLocation;

      if (path == '/' || path == '') {
        return onboardingCompleted ? '/login' : '/onboarding';
      }
      if (path == '/onboarding' && onboardingCompleted) {
        return '/login';
      }
      return null;
    },
    routes: [
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
