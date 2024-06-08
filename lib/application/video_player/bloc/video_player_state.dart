part of 'video_player_bloc.dart';

enum VideoPlayerStatus {
  loading,
  paused,
  error,
  completed,
  fetching,
  playing,
}

class VideoPlayerState extends Equatable {
  final Video currentVideo;
  final double progress;
  final VideoPlayerStatus status;
  final Duration progressSeconds;
  final bool mute;

  const VideoPlayerState(
      {this.currentVideo = const Video(id: '', src: ''),
      this.status = VideoPlayerStatus.fetching,
      this.progress = 0,
      this.progressSeconds = Duration.zero,
      this.mute = false});

  VideoPlayerState copyWith({
    Video? currentVideo,
    VideoPlayerStatus? status,
    double? progress,
    Duration? progressSeconds,
    bool? mute,
  }) =>
      VideoPlayerState(
          currentVideo: currentVideo ?? this.currentVideo,
          status: status ?? this.status,
          progress: progress ?? this.progress,
          progressSeconds: progressSeconds ?? this.progressSeconds,
          mute: mute ?? this.mute);

  @override
  List<Object> get props => [currentVideo, status, mute, progressSeconds];
}
