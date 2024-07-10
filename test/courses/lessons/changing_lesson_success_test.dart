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
            id: '1',
            title: 'title',
            content: 'content',
            video: 'video',
            image: 'image',
            order: 1),
        const Lesson(
            id: '2',
            title: 'title',
            content: 'content',
            video: 'video',
            image: 'image',
            order: 1),
        const Lesson(
            id: '3',
            title: 'title',
            content: 'content',
            video: 'video',
            image: 'image',
            order: 1),
      ],
      level: 'EASY',
      released: DateTime(2024),
    );
    mockCoursesRepository = MockCoursesRepository([mockCourses]);
  });

  blocTest(
    'Should emit LessonsState with LessonsStatus [loaded] and currentLesson, isFirstLesson [false], isLastLesson [false] when changeCurrentLesson is called and succeeds',
    seed: () => LessonsState(
      currentLesson: mockCourses.lessons!.first,
      lessons: mockCourses.lessons!,
      imgSelectedCourse: mockCourses.image,
      isFirstLesson: true,
      isLastLesson: false,
      selectedCourseId: mockCourses.id,
    ),
    build: () => LessonsBloc(coursesRepository: mockCoursesRepository),
    act: (bloc) => bloc.changeCurrentLesson('2'),
    expect: () => [
      LessonsState(
        status: LessonsStatus.loaded,
        currentLesson: mockCourses.lessons!.elementAt(1),
        lessons: mockCourses.lessons!,
        imgSelectedCourse: mockCourses.image,
        isFirstLesson: false,
        isLastLesson: false,
        selectedCourseId: mockCourses.id,
      ),
    ],
  );
}
