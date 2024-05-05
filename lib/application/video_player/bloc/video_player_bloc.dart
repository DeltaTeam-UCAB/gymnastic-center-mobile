import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/services/video_player/video_player_service.dart';
import 'package:gymnastic_center/domain/entities/videos/video.dart';
import 'package:gymnastic_center/domain/repositories/videos/videos_repository.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {

  final VideosRepository videosRepository;
  late  VideoPlayerService videoPlayerService;

  VideoPlayerBloc({
    required this.videosRepository,

  }) : super(const VideoPlayerState()) {
    on<CurrentVideoFetched>(_onCurrentVideoFetched);
    on<CurrentVideoPlayed>(_onCurrentVideoPlayed);
    on<CurrentVideoPaused>(_onCurrentVideoPaused);
    on<CurrentVideoCompleted>(_onCurrentVideoCompleted);
    on<CurrentVideoMuted>(_onCurrentVideoMuted);
    on<CurrentVideoUnmuted>(_onCurrentVideoUnmuted);
    on<CurrentVideoNotFound>(_onCurrentVideoNotFound);
  }

  void _onCurrentVideoCompleted(CurrentVideoCompleted event, Emitter<VideoPlayerState> emit) {
    emit(
      state.copyWith(
        status: VideoPlayerStatus.completed,
      )      
    );
  }  

  void _onCurrentVideoFetched(CurrentVideoFetched event, Emitter<VideoPlayerState> emit){
    emit(
      state.copyWith(
        status: VideoPlayerStatus.loading,
        currentVideo: event.video
      )      
    );
  }

  void _onCurrentVideoPlayed(CurrentVideoPlayed event, Emitter<VideoPlayerState> emit){
    emit(
      state.copyWith(
        status: VideoPlayerStatus.playing
      )
    );
  }

  void _onCurrentVideoPaused(CurrentVideoPaused event, Emitter<VideoPlayerState> emit){
    emit(
      state.copyWith(
        status: VideoPlayerStatus.paused
      )
    );
  }
  
  void _onCurrentVideoMuted(CurrentVideoMuted event, Emitter<VideoPlayerState> emit) {
    emit(
      state.copyWith(
        mute: true
      )
    );
  }

  void _onCurrentVideoUnmuted(CurrentVideoUnmuted event, Emitter<VideoPlayerState> emit) {
    emit(
      state.copyWith(
        mute: false
      )
    );
  }
  
  void _onCurrentVideoNotFound(CurrentVideoNotFound event, Emitter<VideoPlayerState> emit) {
    emit(
      state.copyWith(
        status: VideoPlayerStatus.error
      )
    );
  }

  void setVideoPlayerService(VideoPlayerService videoPlayerService){
    this.videoPlayerService = videoPlayerService;
  }

  Future<void> fetchVideo(String videoId) async {
    final videoResponse = await videosRepository.getVideoById(videoId);
    if (videoResponse.isSuccessful()){
      final video = videoResponse.getValue();
      add(CurrentVideoFetched(video));
      return ;
    }
    add(const CurrentVideoNotFound());
  }

  void playVideo(){
    videoPlayerService.play();
    add(const CurrentVideoPlayed());
  }
  
  void pauseVideo(){
    videoPlayerService.pause();
    add(const CurrentVideoPaused());
  }

  Future<void> initialize() async {
    await videoPlayerService.initialize();
    add(const CurrentVideoPlayed());
  }

  Duration getCurrentPosition(){
    return videoPlayerService.getCurrentPosition();
  }

  Duration getTotalDuration(){
    return videoPlayerService.getTotalDuration();
  }

  void mute(){
    videoPlayerService.setVolume(0);
    add(const CurrentVideoMuted());
  }

  void unmute(){
    videoPlayerService.setVolume(1);
    add(const CurrentVideoUnmuted());
  }

  void videoCompleted(){
    add(const CurrentVideoCompleted());
  }

}
