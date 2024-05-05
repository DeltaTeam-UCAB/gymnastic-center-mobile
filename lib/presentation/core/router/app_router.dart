
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/presentation/screens/home_screen.dart';
import 'package:gymnastic_center/presentation/screens/video_player/video_player_screen.dart';


class RoutesManager {
  static GoRouter appRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      
      GoRoute(
        path: '/video-player/:videoId',
        builder: (context, state) => VideoPlayerScreen(videoId: state.pathParameters['videoId'] ?? ''),
      ),

    ]
  );
}