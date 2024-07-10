import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';
import 'package:gymnastic_center/domain/entities/videos/video.dart';


void main() {
  late Video mockCurrentVideo;

  setUp(() {
    mockCurrentVideo = const Video(id: '1', src: 'url-video');
  });

  blocTest(
      'Should emit VideoPlayerState with status loading and currentVideo when changeCurrentVideo is called',
      build: () => VideoPlayerBloc(),
      act: (bloc) => bloc.changeCurrentVideo(mockCurrentVideo),
      expect: () => [
        isA<VideoPlayerState>()
            .having((state) => state.status, 'status', VideoPlayerStatus.loading)
            .having((state) => state.currentVideo, 'current video', mockCurrentVideo)

      ]);
}
