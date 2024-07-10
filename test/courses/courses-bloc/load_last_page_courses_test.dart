import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

import '../utils/mock_courses_repository.dart';

void main() {
  late CoursesRepository mockCoursesRepository;
  late Course mockCourses;

  setUp(() {
    mockCourses = Course(
      id: 'id',
      title: 'title',
      description: 'description',
      image: 'image',
      trainer:
          Trainer(id: 'id', name: 'name', location: 'location', image: 'image'),
      category: 'category',
      tags: ['tags'],
      durationMinutes: '60',
      durationWeeks: '70',
      lessons: [],
      level: 'EASY',
      released: DateTime(2024),
    );
    mockCoursesRepository = MockCoursesRepository([]);
  });

  blocTest(
    'Should emit CoursesState with isLoading false and isLastPage true when loadNextPage is called and no courses are found',
    seed: () => CoursesState(courses: [mockCourses], isLoading: false),
    build: () => CoursesBloc(coursesRepository: mockCoursesRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      CoursesState(courses: [mockCourses], isLoading: true),
      CoursesState(courses: [mockCourses], isLoading: false, isLastPage: true)
    ],
  );
}
