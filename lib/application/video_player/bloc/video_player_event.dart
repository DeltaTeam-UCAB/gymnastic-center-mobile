part of 'video_player_bloc.dart';

sealed class VideoPlayerEvent {
  const VideoPlayerEvent();
}

class CurrentVideoChanged extends VideoPlayerEvent {
  final Video video;
  const CurrentVideoChanged(this.video);
}

class CurrentVideoProgressUpdated extends VideoPlayerEvent {
  final double progress;
  final Duration progressSeconds;

  const CurrentVideoProgressUpdated(this.progress, this.progressSeconds);
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
