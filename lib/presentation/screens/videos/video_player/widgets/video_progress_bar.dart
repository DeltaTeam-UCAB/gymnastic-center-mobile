import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';

class VideoProgressBar extends StatefulWidget {
  const VideoProgressBar({super.key});

  @override
  State<VideoProgressBar> createState() => _VideoProgressBarState();
}

class _VideoProgressBarState extends State<VideoProgressBar> {

  bool isChanging = false;
  double toChange = 0.0;

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
            value: (isChanging) ? toChange : progressValue,
            min: 0,
            max: 1,
            onChangeStart: (value) {
              isChanging = true;
            },
            onChangeEnd: (value) {
              isChanging = false;
            },
            onChanged: (double value) {
              if (isChanging){
                toChange = value;
                final totalDuration = context.read<VideoPlayerBloc>().getTotalDuration().inMilliseconds;
                final currentPosition = context.read<VideoPlayerBloc>().state.progressSeconds;
                final newPosition = Duration(milliseconds: (totalDuration * value).ceil());
                if ( currentPosition.inSeconds != newPosition.inSeconds){
                  context.read<VideoPlayerBloc>().setNewPositition(newPosition);
                }
              }
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
