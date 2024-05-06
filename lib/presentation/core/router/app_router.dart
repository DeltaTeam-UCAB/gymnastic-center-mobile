import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/presentation/screens/screens.dart';

class RoutesManager {
  static GoRouter appRouter = GoRouter(initialLocation: '/home/0', routes: [
    GoRoute(
        path: '/home/:page',
        builder: (context, state) {
          final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
          return HomeScreen(pageIndex: pageIndex);
        },
        routes: [
          GoRoute(
            path: 'courses',
            builder: (context, state) {
              return const AllCoursesScreen();
            },
          ),
          GoRoute(
            path: 'posts',
            builder: (context, state) {
              return const AllPostsScreen();
            },
          ),
          GoRoute(
            path: 'videos',
            builder: (context, state) {
              return const AllVideosScreen();
            },
          )
        ]),
    GoRoute(
      path: '/video-player/:videoId',
      builder: (context, state) =>
          VideoPlayerScreen(videoId: state.pathParameters['videoId'] ?? ''),
    ),
  ]);
}
