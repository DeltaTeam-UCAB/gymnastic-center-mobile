part of 'video_player_bloc.dart';


enum VideoPlayerStatus{
  loading,
  paused,
  error,
  completed,
  fetching,
  playing,
}

class VideoPlayerState extends Equatable {
  
  final Video currentVideo;
  final VideoPlayerStatus status;
  final bool mute;

  const VideoPlayerState({
    this.currentVideo = const Video(id: '', src: ''),
    this.status = VideoPlayerStatus.fetching,
    this.mute = false
  });

  VideoPlayerState copyWith({
    Video? currentVideo,
    VideoPlayerStatus? status,
    bool? mute,
  })=>VideoPlayerState(
    currentVideo: currentVideo ?? this.currentVideo,
    status: status ?? this.status,
    mute: mute ?? this.mute
  );
  
  @override
  List<Object> get props => [currentVideo, status, mute];
}