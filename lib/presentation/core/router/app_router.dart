
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/presentation/screens/home_screen.dart';


class RoutesManager {
  static GoRouter appRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),

    ]
  );
}