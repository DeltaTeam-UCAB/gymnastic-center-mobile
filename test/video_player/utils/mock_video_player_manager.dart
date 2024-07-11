import 'package:gymnastic_center/application/video_player/video_player_manager.dart';
import 'package:gymnastic_center/common/results.dart';

import 'mock_video_player_manager_state.dart';

class MockVideoPlayerManager extends VideoPlayerManager{
  
  MockVideoPlayerManagerState state;
  final bool shouldFail;
  MockVideoPlayerManager(this.state, [this.shouldFail = false]);

  @override
  Duration getCurrentPosition() {
    return state.currentPosition;
  }

  @override
  Duration getDurationLoaded() {
    return state.totalDuration;
  }

  @override
  Duration getTotalDuration() {
    return state.totalDuration;
  }

  @override
  Future<Result<bool>> initialize() {
    if ( shouldFail ) return Future.value(Result.fail(Exception()));
    state.isInitialized = true;
    return Future.value(Result.success(true));
  }

  @override
  void pause() {
    state.isPaused = true;
  }

  @override
  void play() {
    state.isPlaying = true;
  }

  @override
  Future<Result<bool>> setNewPosition(Duration duration) {
    state.isPositionChanged = true;
    return Future.value(Result.success(true));
  }

  @override
  void setVolume(double volume) {
    state.volume = volume;
  }

}