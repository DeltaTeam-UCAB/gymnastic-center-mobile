import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/presentation/screens/screens.dart';

class RoutesManager {
  static GoRouter appRouter = GoRouter(initialLocation: '/splash', routes: [
    GoRoute(
        path: '/home/:page',
        builder: (context, state) {
          final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
          return HomeScreen(pageIndex: pageIndex);
        },
        routes: [
          GoRoute(
            path: 'course/:courseId',
            builder: (context, state) =>
                CourseScreen(courseId: state.pathParameters['courseId'] ?? ''),
          ),
          GoRoute(
            path: 'video/:videoId',
            builder: (context, state) => VideoPlayerScreen(
                videoId: state.pathParameters['videoId'] ?? ''),
          ),
          GoRoute(
            path: 'courses',
            builder: (context, state) => const AllCoursesScreen(),
          ),
          GoRoute(
            path: 'posts',
            builder: (context, state) => const AllPostsScreen(),
          ),
          GoRoute(
            path: 'videos',
            builder: (context, state) => const AllVideosScreen(),
          ),
        ]),
    GoRoute(
      path: '/video-player/:videoId',
      builder: (context, state) =>
          VideoPlayerScreen(videoId: state.pathParameters['videoId'] ?? ''),
    ),
    GoRoute(
      path: '/post/:postId',
      builder: (context, state) =>
          PostScreen(postId: state.pathParameters['postId'] ?? ''),
    ),
    GoRoute(path: '/start', builder: (context, state) => const StartScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(
          splashScreenDurationSeconds: 3,
          onSplashScreenFade: () => context.go('/welcome')),
    ),
    GoRoute(
        path: '/welcome',
        builder: (context, state) => WelcomeScreen(
              onPressSkip: () => context.go('/start'),
              onPressNextInLastPage: () => context.go('/start'),
            )),
    GoRoute(
        path: '/configuration/theme',
        builder: (context, state) => const ThemeManagerScreen()),
    GoRoute(
      path: '/configuration/notifications',
      builder: (context, state) => const NotificationStatuScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: '/account', builder: (context, state) => const AccountScreen()),
    GoRoute(
        path: '/account/details',
        builder: (context, state) => const AccountDetailsScreen()),
    GoRoute(path: '/token', builder: (context, state) => const TokenScreen()),
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    )
  ]);
}
