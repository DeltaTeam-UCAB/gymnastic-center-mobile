import 'package:gymnastic_center/application/services/video_player/video_player_service.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPlayerService extends VideoPlayerService {
  final VideoPlayerController videoPlayerController;

  NetworkVideoPlayerService(this.videoPlayerController);

  @override
  void pause() {
    videoPlayerController.pause();
  }

  @override
  void play() {
    videoPlayerController.play();
  }

  @override
  void setVolume(double volume) {
    videoPlayerController.setVolume(volume);
  }

  @override
  Future<void> initialize() async {
    videoPlayerController
      ..setLooping(false)
      ..play();
    await videoPlayerController.initialize();
  }

  @override
  Duration getCurrentPosition() {
    return videoPlayerController.value.position;
  }

  @override
  Duration getTotalDuration() {
    return videoPlayerController.value.duration;
  }
}
