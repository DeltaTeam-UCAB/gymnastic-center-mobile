import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/courses/lessons/bloc/lessons_bloc.dart';
import 'package:gymnastic_center/application/suscriptions/course-progress/course_progress_bloc.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';
import 'package:gymnastic_center/domain/entities/videos/video.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/screens/videos/video_player/widgets/full_screen_player.dart';
import 'package:gymnastic_center/presentation/screens/videos/video_player/widgets/video_buttons.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoURL;

  const VideoPlayerScreen({
    required this.videoURL,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<VideoPlayerBloc>()
              ..changeCurrentVideo(Video(id: '', src: videoURL)),
          ),
          BlocProvider.value(
            value: getIt<LessonsBloc>()
          ),
          BlocProvider.value(
            value: getIt<CourseProgressBloc>()
          ),
        ],
        child: const _VideoPlayerView(),
      ),
    );
  }
}

class _VideoPlayerView extends StatelessWidget {
  const _VideoPlayerView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
      buildWhen: (previous, current) {
        return (previous.currentVideo != current.currentVideo) ||
            (current.status == VideoPlayerStatus.error);
      },
      builder: (context, state) {
        if (state.status == VideoPlayerStatus.error) {
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Video not found'),
                  TextButton.icon(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => context.pop(),
                    label: const Text('Return to course'),
                  ),
                ]),
          );
        }
        if (state.status != VideoPlayerStatus.fetching) {
          return Stack(
            children: [
              SizedBox.expand(
                child: FullScreenPlayer(video: state.currentVideo),
              ),
              const VideoButtons()
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
