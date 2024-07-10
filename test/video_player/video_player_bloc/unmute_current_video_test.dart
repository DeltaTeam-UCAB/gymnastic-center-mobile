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
    mockVideoPlayerManagerState = MockVideoPlayerManagerState();
    mockVideoPlayerManager = MockVideoPlayerManager(mockVideoPlayerManagerState);
  });


  
  blocTest(
      'Should emit VideoPlayerState with mute in false when unmute is called',
      build: () => VideoPlayerBloc()..setVideoPlayerManager(mockVideoPlayerManager),
      seed: () => VideoPlayerState(currentVideo: mockCurrentVideo, status: VideoPlayerStatus.playing, mute: true),
      act: (bloc) => bloc.unmute(),
      verify: (_) {
        expect(mockVideoPlayerManagerState.volume, 1.0);
      },
      expect: () => [
        isA<VideoPlayerState>()
            .having((state) => state.mute, 'mute', false)
      ]);
}
