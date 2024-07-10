import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/suscriptions/course-progress/course_progress_bloc.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

import '../utils/mock_suscription_repository.dart';

void main() {
  late SuscriptionRepository mockSuscriptionRepository;
  late CourseProgress mockCoursesProgress;

  setUp(() {
    mockCoursesProgress = CourseProgress(
      courseTitle: 'Course Title',
      percent: 0,
      lastTime: DateTime.now(),
      courseId: '1',
      lessons: [
        const LessonsProgress(lessonId: '1', percent: 0, time: Duration(seconds: 0)),
      ],
      image: 'image',
      trainer: 'Trainer',
    );
    mockSuscriptionRepository = MockSuscriptionRepository([mockCoursesProgress]);
  });

  blocTest(
      'Should emit CourseProgressBlocState with status loaded when loadCurrentCourseProgressById is called',
      build: () => CourseProgressBloc(mockSuscriptionRepository),
      act: (bloc) => bloc.loadCurrentCourseProgressById('1'),
      expect: () => [
        isA<CourseProgressState>()
            .having((state) => state.status, 'status', CourseProgressStatus.loaded)
            .having((state) => state.coursePercent, 'coursePercent', mockCoursesProgress.percent)
            .having((state) => state.lessonsProgress, 'lessonsProgress', mockCoursesProgress.lessons)

      ]);
}
