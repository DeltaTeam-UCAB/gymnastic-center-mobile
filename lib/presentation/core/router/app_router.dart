import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/presentation/screens/posts/post_screen.dart';
import 'package:gymnastic_center/presentation/screens/screens.dart';
import 'package:gymnastic_center/presentation/screens/video_player/video_player_screen.dart';


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
      
      GoRoute(
        path: '/video-player/:videoId',
        builder: (context, state) => VideoPlayerScreen(videoId: state.pathParameters['videoId'] ?? ''),
      ),

      GoRoute(
        path: '/post/:postId',
        builder: (context, state) => PostScreen(postId: state.pathParameters['postId'] ?? ''),
      ),

    ]
  );
}