import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';
import 'package:gymnastic_center/application/video_player/video_player_manager.dart';
import 'package:gymnastic_center/domain/entities/videos/video.dart';

import '../utils/mock_video_player_manager.dart';
import '../utils/mock_video_player_manager_state.dart';

void main() {
  late Video mockCurrentVideo;
  late VideoPlayerManager mockVideoPlayerManager;
  late MockVideoPlayerManagerState mockVideoPlayerManagerState;
  setUp(() {
    mockCurrentVideo = const Video(id: '1', src: 'url-video');
    mockVideoPlayerManagerState = MockVideoPlayerManagerState(totalDuration: const Duration(seconds: 120), currentPosition: const Duration(seconds: 60));
    mockVideoPlayerManager = MockVideoPlayerManager(mockVideoPlayerManagerState);
  });


  
  blocTest(
      'Should emit VideoPlayerState with new progress 50% and progress in seconds 60 when updateProgress up is called',
      build: () => VideoPlayerBloc()..setVideoPlayerManager(mockVideoPlayerManager),
      seed: () => VideoPlayerState(currentVideo: mockCurrentVideo, status: VideoPlayerStatus.playing),
      act: (bloc) => bloc.updateProgress(),
      expect: () => [
        isA<VideoPlayerState>()
            .having((state) => state.progress, 'progress', 0.5 )
            .having((state) => state.progressSeconds, 'progress in seconds', const Duration(seconds: 60) )
      ]);
}
