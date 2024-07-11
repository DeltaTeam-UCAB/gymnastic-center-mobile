import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/courses/lessons/bloc/lessons_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

import '../utils/mock_courses_repository.dart';

void main() {
  late CoursesRepository mockCoursesRepository;
  late Course mockCourses;

  setUp(() {
    mockCourses = Course(
      id: '1',
      title: 'title',
      description: 'description',
      image: 'image',
      trainer:
          Trainer(id: 'id', name: 'name', location: 'location', image: 'image'),
      category: 'category',
      tags: ['tags'],
      durationMinutes: '60',
      durationWeeks: '70',
      lessons: [
        const Lesson(
            id: 'id',
            title: 'title',
            content: 'content',
            video: 'video',
            order: 1)
      ],
      level: 'EASY',
      released: DateTime(2024),
    );
    mockCoursesRepository = MockCoursesRepository([mockCourses]);
  });

  blocTest(
    'Should emit LessonsState with LessonsStatus [changingLesson], lessons, imgSelectedCourse, selectedCourseId when loadLessonsByCourseId is called and succeeds',
    build: () => LessonsBloc(coursesRepository: mockCoursesRepository),
    act: (bloc) => bloc.loadLessonsByCourseId('1'),
    expect: () => [
      LessonsState(
        status: LessonsStatus.changingLesson,
        lessons: mockCourses.lessons,
        imgSelectedCourse: mockCourses.image,
        selectedCourseId: mockCourses.id,
      ),
    ],
  );
}
