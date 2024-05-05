import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';

class VolumeButton extends StatelessWidget {
  const VolumeButton({super.key});

  void toggleMute(BuildContext context, bool mute){
    if ( mute ){
      context.read<VideoPlayerBloc>().unmute();
      return;
    }
    context.read<VideoPlayerBloc>().mute();

  }

  @override
  Widget build(BuildContext context) {
    final VideoPlayerState state = context.watch<VideoPlayerBloc>().state;
    return IconButton(
      onPressed: () { 
        toggleMute(context,state.mute);
      },
      icon: (state.mute)
        ? const Icon(Icons.volume_off)
        : const Icon(Icons.volume_up),
        color: Colors.white,
    );
  }
}
