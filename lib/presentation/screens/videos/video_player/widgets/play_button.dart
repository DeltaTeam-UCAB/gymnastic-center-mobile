import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({super.key});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  void play(BuildContext context) {
    context.read<VideoPlayerBloc>().playVideo();
  }

  void pause(BuildContext context) {
    context.read<VideoPlayerBloc>().pauseVideo();
  }
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration( milliseconds: 500));
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final VideoPlayerState state = context.watch<VideoPlayerBloc>().state;

    return IconButton(
      onPressed: () {
        if (state.status == VideoPlayerStatus.paused) {
          play(context);
          _animationController.reverse();
          return;
        }
        _animationController.forward();
        pause(context);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.pause_play,
        progress: _animationController
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(colors.primary),
        iconColor: const MaterialStatePropertyAll(Colors.white),
        iconSize: MaterialStateProperty.all(40.0),
        minimumSize: MaterialStateProperty.all(const Size(50.0, 50.0)),
      ),
    );
  }
}
