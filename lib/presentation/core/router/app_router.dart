import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/presentation/screens/screens.dart';

class RoutesManager {
  static GoRouter appRouter = GoRouter(
    initialLocation: '/home/0',
    routes: [
      GoRoute(
        path: '/home/:page',
        builder: (context, state){
          final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
          return HomeScreen(pageIndex: pageIndex );
        },
        // routes: [] TODO: Add nested routes here.
      ),
    ]
  );
}