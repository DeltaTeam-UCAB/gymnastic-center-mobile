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
        const LessonsProgress(lessonId: '2', percent: 0, time: Duration(seconds: 0)),
      ],
      image: 'image',
      trainer: 'Trainer',
    );
    mockSuscriptionRepository = MockSuscriptionRepository([mockCoursesProgress]);
  });

  blocTest(
      'Should emit CourseProgressBlocState with 50% course percent and 100% firsst lesson percent when markCompletedLesson is called',
      build: () => CourseProgressBloc(mockSuscriptionRepository,),
      seed: () => CourseProgressState(status: CourseProgressStatus.loaded, coursePercent: mockCoursesProgress.percent, lessonsProgress: mockCoursesProgress.lessons),
      act: (bloc)  {
        bloc.markCompletedLesson('1', '1');
      },
      expect: () => [
        isA<CourseProgressState>()
          .having((state) => state.coursePercent, 'coursePercent', 50)
          .having((state) => state.lessonsProgress[0].percent, 'lessonsProgress percent', 100)

      ]);
}
