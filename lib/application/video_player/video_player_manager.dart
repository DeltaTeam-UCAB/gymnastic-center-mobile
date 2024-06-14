import 'package:gymnastic_center/common/results.dart';

abstract class VideoPlayerManager {
  Future<Result<bool>> initialize();
  void play();
  void pause();
  void setVolume(double volume);
  Duration getTotalDuration();
  Duration getCurrentPosition();
  Future<Result<bool>> setNewPosition( Duration duration );
  Duration getDurationLoaded();
}
