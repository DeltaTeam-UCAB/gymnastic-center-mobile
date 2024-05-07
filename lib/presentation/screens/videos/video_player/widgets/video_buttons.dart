import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';
import 'package:gymnastic_center/presentation/screens/videos/video_player/widgets/play_button.dart';
import 'package:gymnastic_center/presentation/screens/videos/video_player/widgets/total_duration_text.dart';
import 'package:gymnastic_center/presentation/screens/videos/video_player/widgets/video_progress_bar.dart';
import 'package:gymnastic_center/presentation/screens/videos/video_player/widgets/volume_button.dart';

class VideoButtons extends StatelessWidget {
  const VideoButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerBloc, VideoPlayerState>(
      builder: (context, state) {
        if (state.status == VideoPlayerStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == VideoPlayerStatus.completed) {
          return const _VideoCompletedLayer();
        }
        return const _VideoButtonsLayer();
      },
    );
  }
}

class _VideoCompletedLayer extends StatelessWidget {
  const _VideoCompletedLayer();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge!;
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('🎉Lesson finished!',
                style: TextStyle(
                    color: Colors.white, fontSize: textStyle.fontSize)),
            TextButton.icon(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => context.pop(),
              label: const Text('Return to course'),
            ),
          ],
        )),
      ],
    );
  }
}

class _VideoButtonsLayer extends StatefulWidget {
  const _VideoButtonsLayer();

  @override
  State<_VideoButtonsLayer> createState() => _VideoButtonsLayerState();
}

class _VideoButtonsLayerState extends State<_VideoButtonsLayer> {
  bool _showLayer = true;

  void _handleOnTapDown(TapDownDetails details) {
    _showLayer = !_showLayer;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _handleOnTapDown(details);
      },
      child: AnimatedOpacity(
        opacity: _showLayer ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => context.pop(),
                color: Colors.white,
              ),
            ),
            const Expanded(child: Center(child: PlayButton())),
            const Positioned(bottom: 70, right: 20, child: VolumeButton()),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                  child: VideoProgressBar()),
            ),
            const Positioned(
              bottom: 30,
              right: 20,
              child: TotalDurationText(),
            ),
          ],
        ),
      ),
    );
  }
}
