import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  void play(BuildContext context) {
    context.read<VideoPlayerBloc>().playVideo();
  }

  void pause(BuildContext context) {
    context.read<VideoPlayerBloc>().pauseVideo();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final VideoPlayerState state = context.watch<VideoPlayerBloc>().state;

    return IconButton(
      onPressed: () {
        if (state.status == VideoPlayerStatus.paused) {
          play(context);
          return;
        }
        pause(context);
      },
      icon: Icon((state.status != VideoPlayerStatus.paused)
          ? Icons.pause
          : Icons.play_arrow),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(colors.primary),
        iconColor: const MaterialStatePropertyAll(Colors.white),
        iconSize: MaterialStateProperty.all(40.0),
        minimumSize: MaterialStateProperty.all(Size(50.0, 50.0)),
      ),
    );
  }
}
