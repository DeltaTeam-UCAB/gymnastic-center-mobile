import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';

class VideoProgressBar extends StatelessWidget {
  const VideoProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(microseconds: 100), (_) {
        return context.read<VideoPlayerBloc>().updateProgress();
      }).takeWhile((value) => value < 1),
      builder: (context, snapshot) {
        double progressValue = snapshot.data ?? 0;
        if (snapshot.connectionState == ConnectionState.done) {
          progressValue = 1;
        }
        return SizedBox(
          height: 40,
          width: double.infinity,
          child: Slider(
            value: progressValue,
            min: 0,
            max: 1,
            onChanged: (double value) {
              print('Tocando');
            },
          ),
        );
      },
    );
  }
}

class LoadedVideoProgressBar extends StatelessWidget {
  const LoadedVideoProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(microseconds: 100), (_) {
        return context.read<VideoPlayerBloc>().getDurationLoaded().inMilliseconds 
            / context.read<VideoPlayerBloc>().getTotalDuration().inMilliseconds;
      }).takeWhile((value) => value < 1),
      builder: (context, snapshot) {
        double progressValue = snapshot.data ?? 0;
        if (snapshot.connectionState == ConnectionState.done) {
          progressValue = 1;
        }
        return LinearProgressIndicator(
          value: progressValue,
          color: Color(Colors.grey.value),
        );
      },
    );
  }
}
