import 'package:go_router/go_router.dart';
import 'package:resilio/core/di/injection.dart';
import 'package:resilio/core/routing/navigation_service.dart';
import 'package:resilio/core/routing/route_names.dart';

import '../../features/customer/auth/presentation/screens/login_screen.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: getIt<NavigationService>().navigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(
        name: RouteNames.login,
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      // Future routes can be added here
    ],
  );
}
