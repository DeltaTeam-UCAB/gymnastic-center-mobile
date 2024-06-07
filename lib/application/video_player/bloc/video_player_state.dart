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
  final bool mute;

  const VideoPlayerState(
      {this.currentVideo = const Video(id: '', src: ''),
      this.status = VideoPlayerStatus.fetching,
      this.progress = 0,
      this.mute = false});

  VideoPlayerState copyWith({
    Video? currentVideo,
    VideoPlayerStatus? status,
    double? progress,
    bool? mute,
  }) =>
      VideoPlayerState(
          currentVideo: currentVideo ?? this.currentVideo,
          status: status ?? this.status,
          progress: progress ?? this.progress,
          mute: mute ?? this.mute);

  @override
  List<Object> get props => [currentVideo, status, mute];
}
