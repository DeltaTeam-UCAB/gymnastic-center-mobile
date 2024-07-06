import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

import '../utils/mock_courses_repository.dart';

void main() {
  late CoursesRepository mockCoursesRepository;

  setUp(() {
    mockCoursesRepository = MockCoursesRepository([], true);
  });

  blocTest(
    'Should emit CoursesState with isLoading true and isError true when loadNextPage is called and an error occurs',
    build: () => CoursesBloc(coursesRepository: mockCoursesRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const CoursesState(courses: [], isLoading: true),
      const CoursesState(courses: [], isLoading: false, isError: true)
    ],
  );
}
