import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/suscriptions/trending-progress/trending_progress_bloc.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

import '../utils/mock_suscription_repository.dart';

void main() {
  late SuscriptionRepository mockSuscriptionRepository;
  late CourseProgress mockCourseProgress;

  setUp(() {
    mockCourseProgress = CourseProgress(
      courseTitle: 'Course Title',
      percent: 0,
      lastTime: DateTime.now(),
      courseId: '1',
      lessons: [
        const LessonsProgress(lessonId: '1', percent: 0, time: Duration(seconds: 0)),
        const LessonsProgress(lessonId: '2', percent: 0, time: Duration(seconds: 0)),
        const LessonsProgress(lessonId: '3', percent: 0, time: Duration(seconds: 0)),
      ],
      image: 'image',
      trainer: 'Trainer',
    );
    mockSuscriptionRepository = MockSuscriptionRepository([mockCourseProgress]);
  });

  blocTest(
      'should emit loaded when loadTrendingCourseProgress is called',
      build: () => TrendingProgressBloc(mockSuscriptionRepository),
      act: (bloc) => bloc.loadTrendingCourseProgress(),
      expect: () => [
            isA<TrendingProgressState>()
                .having((state) => state.status, 'status', TrendingProgressStatus.loaded)
                .having((state) => state.trendingCourseProgress, 'trendingCourseProgress', mockCourseProgress)
          ]);
}
