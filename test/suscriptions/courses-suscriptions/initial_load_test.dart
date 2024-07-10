import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/suscriptions/courses-suscriptions/courses_suscriptions_bloc.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

import '../utils/mock_suscription_repository.dart';

void main() {
  late SuscriptionRepository mockSuscriptionRepository;
  late List<CourseProgress> mockCoursesProgress;

  setUp(() {
    mockCoursesProgress = [
      CourseProgress(
        courseTitle: 'Course Title',
        percent: 0,
        lastTime: DateTime.now(),
        courseId: '1',
        lessons: [
          const LessonsProgress(lessonId: '1', percent: 0, time: Duration(seconds: 0)),
        ],
        image: 'image',
        trainer: 'Trainer',
      ),
      CourseProgress(
        courseTitle: 'Course Title',
        percent: 0,
        lastTime: DateTime.now(),
        courseId: '2',
        lessons: [
          const LessonsProgress(lessonId: '1', percent: 0, time: Duration(seconds: 0)),
        ],
        image: 'image',
        trainer: 'Trainer',
      ),
      CourseProgress(
        courseTitle: 'Course Title',
        percent: 0,
        lastTime: DateTime.now(),
        courseId: '3',
        lessons: [
          const LessonsProgress(lessonId: '1', percent: 0, time: Duration(seconds: 0)),
        ],
        image: 'image',
        trainer: 'Trainer',
      ),
    ];
    mockSuscriptionRepository = MockSuscriptionRepository(mockCoursesProgress);
  });

  blocTest(
      'Should emit CoursesSuscriptionsState with status loaded when initialLoading is called',
      build: () => CoursesSuscriptionsBloc(mockSuscriptionRepository),
      act: (bloc) => bloc.initialLoading(perPage: 2),
      expect: () => [
        isA<CoursesSuscriptionsState>()
            .having((state) => state.status, 'status', CoursesSuscriptionsStatus.loaded)
            .having((state) => state.isLastPage, 'isLastPage', false)
            .having((state) => state.coursesSuscribed, 'coursesSuscribed', mockCoursesProgress.sublist(0,2))
            .having((state) => state.page, 'page', 1),
      ]);
}
