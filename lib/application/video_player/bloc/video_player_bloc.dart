import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/video_player/video_player_manager.dart';
import 'package:gymnastic_center/domain/entities/videos/video.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  late VideoPlayerManager videoPlayerManager;

  VideoPlayerBloc() : super(const VideoPlayerState()) {
    on<CurrentVideoChanged>(_onCurrentVideoChanged);
    on<CurrentVideoProgressUpdated>(_onCurrentVideoProgressUpdated);
    on<CurrentVideoPlayed>(_onCurrentVideoPlayed);
    on<CurrentVideoPaused>(_onCurrentVideoPaused);
    on<CurrentVideoCompleted>(_onCurrentVideoCompleted);
    on<CurrentVideoMuted>(_onCurrentVideoMuted);
    on<CurrentVideoUnmuted>(_onCurrentVideoUnmuted);
    on<CurrentVideoNotFound>(_onCurrentVideoNotFound);
  }

  void _onCurrentVideoCompleted(
      CurrentVideoCompleted event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(
      status: VideoPlayerStatus.completed,
      progress: 1
    ));
  }

  void _onCurrentVideoProgressUpdated(
      CurrentVideoProgressUpdated event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(
      progress: event.progress,
      progressSeconds: event.progressSeconds
    ));
  }

  void _onCurrentVideoChanged(
      CurrentVideoChanged event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(
      status: VideoPlayerStatus.loading,
      currentVideo: event.video
    ));
  }

  void _onCurrentVideoPlayed(
      CurrentVideoPlayed event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(status: VideoPlayerStatus.playing));
  }

  void _onCurrentVideoPaused(
      CurrentVideoPaused event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(status: VideoPlayerStatus.paused));
  }

  void _onCurrentVideoMuted(
      CurrentVideoMuted event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(mute: true));
  }

  void _onCurrentVideoUnmuted(
      CurrentVideoUnmuted event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(mute: false));
  }

  void _onCurrentVideoNotFound(
      CurrentVideoNotFound event, Emitter<VideoPlayerState> emit) {
    emit(state.copyWith(status: VideoPlayerStatus.error));
  }

  void setVideoPlayerManager(VideoPlayerManager videoPlayerManager) {
    this.videoPlayerManager = videoPlayerManager;
  }

  void changeCurrentVideo(Video video) {
    add(CurrentVideoChanged(video));
  }

  void playVideo() {
    videoPlayerManager.play();
    add(const CurrentVideoPlayed());
  }

  void pauseVideo() {
    videoPlayerManager.pause();
    add(const CurrentVideoPaused());
  }

  Future<void> initialize() async {
    final initResult = await videoPlayerManager.initialize();
    if (initResult.isSuccessful()){
      add(const CurrentVideoPlayed());
      return ;
    } 
    add(const CurrentVideoNotFound());
  }

  double updateProgress(){
    final currentPosition = videoPlayerManager.getCurrentPosition().inMilliseconds;
    final totalDuration = videoPlayerManager.getTotalDuration().inMilliseconds;
    final progress = (currentPosition / totalDuration);
    if (progress == 1) {
      add(const CurrentVideoCompleted());
      return progress;
    }
    add(CurrentVideoProgressUpdated(progress, videoPlayerManager.getCurrentPosition()));
    return progress;
  }

  Duration getDurationLoaded(){
    return videoPlayerManager.getDurationLoaded();
  }

  Duration getTotalDuration() {
    return videoPlayerManager.getTotalDuration();
  }

  void mute() {
    videoPlayerManager.setVolume(0);
    add(const CurrentVideoMuted());
  }

  void unmute() {
    videoPlayerManager.setVolume(1);
    add(const CurrentVideoUnmuted());
  }

  void videoCompleted() {
    add(const CurrentVideoCompleted());
  }
}
