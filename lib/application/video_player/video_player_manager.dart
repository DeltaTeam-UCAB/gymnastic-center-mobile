abstract class VideoPlayerManager {
  Future<void> initialize();
  void play();
  void pause();
  void setVolume(double volume);
  Duration getTotalDuration();
  Duration getCurrentPosition();
}