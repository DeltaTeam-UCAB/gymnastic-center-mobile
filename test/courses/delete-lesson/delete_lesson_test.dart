import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/courses/delete-lesson/delete_lesson_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';

import '../utils/mock_courses_repository.dart';


void main() {
  late MockCoursesRepository mockCoursesRepository;
  late List<Course> mockCourses;
  setUp(() {
    mockCourses = [
      Course(
        id: '1',
        title: 'Course 1',
        description: 'Description 1',
        trainer: Trainer(id: '1', name: 'name', location: 'location', image: 'image'),
        category: 'Category 1',
        image: 'Image 1',
        tags: ['Tag 1'],
        level: 'Level 1',
        released: DateTime(2024, 6, 21),
        durationMinutes: '400',
        durationWeeks: '4',
        lessons: [
          const Lesson(
            id: '1',
            title: 'Lesson 1',
            content: 'Content 1',
            order: 1,
            video: 'video 1',
          )
        ])
    ];
    mockCoursesRepository = MockCoursesRepository(mockCourses);
  });

  blocTest(
      'Should emit DeleteLessonState with status [deleted] when deleteLesson is called and succeeds',
      build: () => DeleteLessonBloc(mockCoursesRepository),
      act: (bloc) => bloc.deleteLesson(
        courseId: '1',
        lessonId: '1',
      ),
      verify: (_) {
        expect(mockCoursesRepository.courses.first.lessons.length, 0);
      },
      expect: () => [
        isA<DeleteLessonState>()
          .having((state) => state.status, 'status', DeleteLessonStatus.deleting),
        isA<DeleteLessonState>()
          .having((state) => state.status, 'status', DeleteLessonStatus.deleted),
      ]);
}
 