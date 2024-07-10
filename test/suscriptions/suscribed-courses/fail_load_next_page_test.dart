import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/suscriptions/suscribed-courses/suscribed_courses_bloc.dart';
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
    ];
    mockSuscriptionRepository = MockSuscriptionRepository(mockCoursesProgress,true);
  });

  blocTest(
      'Should emit SuscribedCoursesState with status error when loadNextPage is called and repository fails',
      build: () => SuscribedCoursesBloc(mockSuscriptionRepository),
      act: (bloc) => bloc.loadNextPage(perPage: 2),
      seed: () => SuscribedCoursesState(
          status: SuscribedCoursesStatus.loaded,
          isLastPage: false,
          coursesSuscribed: mockCoursesProgress.sublist(0, 2),
          page: 1),
      expect: () => [
        isA<SuscribedCoursesState>()
            .having((state) => state.status, 'status', SuscribedCoursesStatus.loading),
        isA<SuscribedCoursesState>()
            .having((state) => state.status, 'status', SuscribedCoursesStatus.error)
      ]);
}
