import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

import '../utils/mock_courses_repository.dart';

void main() {
  late CoursesRepository mockCoursesRepository;
  late Course courseMock;

  setUp(() {
    courseMock = Course(
        id: '1',
        title: 'Course 1',
        description: 'Description 1',
        trainer: Trainer(id: '1', name: 'name', location: 'location'),
        category: 'Category 1',
        image: 'Image 1',
        tags: ['Tag 1'],
        level: 'Level 1',
        released: DateTime(2024, 6, 21),
        durationMinutes: '400',
        durationWeeks: '4',
        lessons: []);
    mockCoursesRepository = MockCoursesRepository([courseMock]);
  });

  blocTest(
      'Should emit CoursesState with isLoading true and courses [course] when loadNextPage is called',
      build: () => CoursesBloc(coursesRepository: mockCoursesRepository),
      act: (bloc) => bloc.loadNextPage(),
      expect: () => [
            const CoursesState(courses: [], isLoading: true),
            CoursesState(courses: [courseMock], isLoading: false, page: 2)
          ]);
}
