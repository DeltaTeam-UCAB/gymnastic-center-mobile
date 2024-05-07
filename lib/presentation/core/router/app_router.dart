import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/presentation/screens/courses/course_screen.dart';
import 'package:gymnastic_center/presentation/screens/screens.dart';
import 'package:gymnastic_center/presentation/screens/videos/video_player/video_player_screen.dart';


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
        routes: [
          GoRoute(
            path: 'course/:courseId',
            builder: (context, state) => CourseScreen(courseId: state.pathParameters['courseId'] ?? ''),
          ),

          GoRoute(
            path: 'video/:videoId',
            builder: (context, state) => VideoPlayerScreen(videoId: state.pathParameters['videoId'] ?? ''),
          ),
        ],
      ),
      
      GoRoute(
        path: '/video-player/:videoId',
        builder: (context, state) => VideoPlayerScreen(videoId: state.pathParameters['videoId'] ?? ''),
      ),
    ]
  );
}