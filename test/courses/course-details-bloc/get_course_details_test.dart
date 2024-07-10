import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/courses/course-details/course_details_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

import '../utils/mock_courses_repository.dart';

void main() {
  late CoursesRepository mockCoursesRepository;
  late Course mockCourse;

  setUp(() {
    mockCourse = Course(
        id: '1',
        title: 'Course 1',
        description: 'Description 1',
        trainer: Trainer(id: '1', name: 'name', location: 'location', image: 'image'),
        category: 'Category 1',
        image: 'Image 1',
        tags: ['Tag 1'],
        level: 'Level 1',
        durationMinutes: '400',
        durationWeeks: '4',
        released: DateTime(2024, 6, 21),
        lessons: []);
    mockCoursesRepository = MockCoursesRepository([mockCourse]);
  });

  blocTest(
      'Should emit CourseDetailsState with status loading and loaded when getCourseById is called',
      build: () => CourseDetailsBloc(mockCoursesRepository),
      act: (bloc) => bloc.getCourseById('1'),
      expect: () => [
            isA<CourseDetailsState>()
                .having((state) => state.status, 'status',
                    CourseDetailsStatus.loading)
                .having((state) => state.course, 'course', initialCourse),
            isA<CourseDetailsState>()
                .having((state) => state.status, 'status',
                    CourseDetailsStatus.loaded)
                .having((state) => state.course, 'course', mockCourse)
          ]);
}
