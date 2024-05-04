import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/presentation/screens/auth/start_screen.dart';
import 'package:gymnastic_center/presentation/screens/home_screen.dart';
import 'package:gymnastic_center/presentation/screens/splash_screen.dart';
import 'package:gymnastic_center/presentation/screens/welcome_screen.dart';

class RoutesManager {
  static GoRouter appRouter = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/test',
      builder: (context, state) => const StartScreen(),
    ),
  ]);
}
