import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/courses/delete-course/delete_course_bloc.dart';
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
        lessons: [])
    ];
    mockCoursesRepository = MockCoursesRepository(mockCourses);
  });

  blocTest(
      'Should emit DeleteCourseState with status deleted and refresh when deleteCourse is called',
      build: () => DeleteCourseBloc(mockCoursesRepository),
      act: (bloc) => bloc.deleteCourse('1'),
      verify: (_) {
        expect(mockCoursesRepository.courses.length, 0);
      },
      expect: () => [
        isA<DeleteCourseState>()
          .having((state) => state.status, 'status', DeleteCourseStatus.deleting),
        isA<DeleteCourseState>()
          .having((state) => state.status, 'status', DeleteCourseStatus.deleted),
      ]);
}
 