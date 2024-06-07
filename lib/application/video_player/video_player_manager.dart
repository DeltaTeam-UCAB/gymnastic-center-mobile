import 'package:gymnastic_center/common/results.dart';

abstract class VideoPlayerManager {
  Future<Result<void>> initialize();
  void play();
  void pause();
  void setVolume(double volume);
  Duration getTotalDuration();
  Duration getCurrentPosition();
}
