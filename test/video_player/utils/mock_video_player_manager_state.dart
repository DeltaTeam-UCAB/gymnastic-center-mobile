class MockVideoPlayerManagerState {
  bool isInitialized;
  bool isPlaying;
  bool isPaused;
  bool isCompleted;
  bool isPositionChanged;
  double volume;
  Duration currentPosition;
  Duration totalDuration;

  MockVideoPlayerManagerState({
    this.isInitialized = false, 
    this.isPaused = false, 
    this.isPlaying = false, 
    this.isCompleted = false, 
    this.isPositionChanged = false, 
    this.volume = 1.0, 
    this.currentPosition = Duration.zero,
    this.totalDuration = Duration.zero,
  });
  
}