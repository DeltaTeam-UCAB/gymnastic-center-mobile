import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/presentation/screens/categories/categories_screen.dart';
import 'package:gymnastic_center/presentation/screens/screens.dart';

class RoutesManager {
  static GoRouter appRouter = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
          path: '/home/:page',
          builder: (context, state) {
            final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
            return HomeScreen(pageIndex: pageIndex);
          },
          routes: [
            GoRoute(
              path: 'course/:courseId',
              builder: (context, state) => CourseScreen(
                  courseId: state.pathParameters['courseId'] ?? ''),
            ),
            GoRoute(
              path: 'course/:courseId/:selectedLessonId',
              builder: (context, state) => LessonScreen(
                  courseId: state.pathParameters['courseId'] ?? '',
                  selectedLessonId:
                      state.pathParameters['selectedLessonId'] ?? ''),
            ),
            GoRoute(
              path: 'video-player',
              builder: (context, state) =>
                  VideoPlayerScreen(videoURL: (state.extra as String)),
            ),
            GoRoute(
              path: 'categories',
              builder: (context, state) => const AllCategoriesScreen(),
            ),
            GoRoute(
              path: 'courses/:categoryId',
              builder: (context, state) => AllCoursesScreen(
                selectedCategoryId: state.pathParameters['categoryId'] ?? '',
              ),
            ),
            GoRoute(
              path: 'courses',
              builder: (context, state) => const AllCoursesScreen(),
            ),
            GoRoute(
              path: 'blogs',
              builder: (context, state) => const AllBlogsScreen(),
            ),
            GoRoute(
              path: 'videos',
              builder: (context, state) => const AllVideosScreen(),
            ),
            GoRoute(
              path: 'trainer/:trainerId',
              builder: (context, state) => TrainerScreen(
                  trainerId: state.pathParameters['trainerId'] ?? ''),
            ),
          ]),
      GoRoute(
          path: '/video-player',
          builder: (context, state) {
            return VideoPlayerScreen(videoURL: (state.extra as String));
          }),
      GoRoute(
        path: '/blog/:blogId',
        builder: (context, state) =>
            BlogScreen(blogId: state.pathParameters['blogId'] ?? ''),
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
          path: '/password/reset',
          builder: (context, state) => const ResetPasswordScreen()),
      GoRoute(
          path: '/password/create',
          builder: (context, state) => const CreatePasswordScreen()),
      GoRoute(
          path: '/password/verify',
          builder: (context, state) => const VerificationCodeScreen()),
      GoRoute(
          path: '/password/changed',
          builder: (context, state) => const PasswordChangedScreen()),
      GoRoute(
        path: '/',
        redirect: (_, __) => '/home/0',
      )
    ],
    redirect: (context, state) async {
      final isGoingTo = state.matchedLocation;
      final isAutorized =
          await LocalStorageService().getValue<String>('token') != null;
      final hasSeenWelcome =
          await LocalStorageService().getValue<bool>('initialized') != null;

      if (isGoingTo == '/splash') return null;

      if (!isAutorized) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/password/reset' ||
            isGoingTo == '/password/create' ||
            isGoingTo == '/password/verify' ||
            isGoingTo == '/password/changed') return null;
        if (isGoingTo == '/welcome' && !hasSeenWelcome) return null;
        return '/start';
      }

      if (isGoingTo == '/welcome') {
        if (isAutorized) return '/';
        if (hasSeenWelcome) return '/start';
        return null;
      }

      return null;
    },
  );
}
