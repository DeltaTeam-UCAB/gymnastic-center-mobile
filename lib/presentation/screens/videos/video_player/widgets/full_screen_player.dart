import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';
import 'package:gymnastic_center/domain/entities/videos/video.dart';
import 'package:gymnastic_center/infrastructure/video_player/network_video_player_manager.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final Video video;

  const FullScreenPlayer({super.key, required this.video});

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController _controller;
  late NetworkVideoPlayerManager service;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.src));

    service = NetworkVideoPlayerManager(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> initialize(BuildContext context) async {
    await context.read<VideoPlayerBloc>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    context.read<VideoPlayerBloc>().setVideoPlayerManager(service);
    return FutureBuilder(
        future: initialize(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller));
          }
          return Container(
            decoration: BoxDecoration(color: Colors.grey.shade800),
          );
        });
  }
}
