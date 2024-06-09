import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';

class TotalDurationText extends StatelessWidget {
  const TotalDurationText({super.key});

  String totalDurationToString(Duration duration) {
    int minutes = duration.inMinutes;
    late int remainingSeconds;
    if (minutes != 0) {
      remainingSeconds = duration.inSeconds % minutes;
    } else {
      remainingSeconds = duration.inSeconds;
    }

    String minutesString = minutes.toString().padLeft(2, '0');
    String secondsString = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesString:$secondsString';
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = context.read<VideoPlayerBloc>().getTotalDuration();
    return Text(
      totalDurationToString(duration),
      style: const TextStyle(color: Colors.white),
    );
  }
}

class ViewedDurationText extends StatelessWidget {
  const ViewedDurationText({super.key});

  String viewedDurationToString(Duration duration) {
    int minutes = duration.inMinutes;
    late int remainingSeconds;
    if (minutes != 0) {
      remainingSeconds = duration.inSeconds % minutes;
    } else {
      remainingSeconds = duration.inSeconds;
    }

    String minutesString = minutes.toString().padLeft(2, '0');
    String secondsString = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesString:$secondsString';
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = context.watch<VideoPlayerBloc>().state.progressSeconds;
    return Text(
      viewedDurationToString(duration),
      style: const TextStyle(color: Colors.white),
    );
  }
}
