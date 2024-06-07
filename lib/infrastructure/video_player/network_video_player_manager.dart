import 'package:gymnastic_center/application/video_player/video_player_manager.dart';
import 'package:gymnastic_center/common/results.dart';
import 'package:video_player/video_player.dart';

class NetworkVideoPlayerManager extends VideoPlayerManager {
  final VideoPlayerController videoPlayerController;

  NetworkVideoPlayerManager(this.videoPlayerController);

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
  Future<Result<void>> initialize() async {
    try {
      videoPlayerController
        ..setLooping(false)
        ..play();
      await videoPlayerController.initialize();  
      return Result.success(null);
    } catch (e) {
      return Result.fail(e as Exception);
    }
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
