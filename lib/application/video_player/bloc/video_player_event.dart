part of 'video_player_bloc.dart';

sealed class VideoPlayerEvent {
  const VideoPlayerEvent();
}

class CurrentVideoFetched extends VideoPlayerEvent {
  final Video video;
  const CurrentVideoFetched(this.video);
}

class CurrentVideoLoaded extends VideoPlayerEvent {
  const CurrentVideoLoaded();
}

class CurrentVideoPlayed extends VideoPlayerEvent {
  const CurrentVideoPlayed();
}

class CurrentVideoPaused extends VideoPlayerEvent {
  const CurrentVideoPaused();
}

class CurrentVideoMuted extends VideoPlayerEvent {
  const CurrentVideoMuted();
}

class CurrentVideoUnmuted extends VideoPlayerEvent {
  const CurrentVideoUnmuted();
}

class CurrentVideoCompleted extends VideoPlayerEvent {
  const CurrentVideoCompleted();
}

class CurrentVideoNotFound extends VideoPlayerEvent {
  const CurrentVideoNotFound();
}
