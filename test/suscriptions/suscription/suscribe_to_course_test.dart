import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/suscriptions/suscription/suscription_bloc.dart';
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
      'Should emit SuscriptionState with status suscribed when suscribeToCourse is called',
      build: () => SuscriptionBloc(mockSuscriptionRepository),
      act: (bloc) => bloc.suscribeToCourse('1'),
      expect: () => [
        isA<SuscriptionState>()
            .having((state) => state.status, 'status', SuscribedStatus.suscribed)
      ]);
}
