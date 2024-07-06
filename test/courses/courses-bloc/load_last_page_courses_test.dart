import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

import '../utils/mock_courses_repository.dart';

void main() {
  late CoursesRepository mockCoursesRepository;

  setUp(() {
    mockCoursesRepository = MockCoursesRepository([]);
  });

  blocTest(
    'Should emit CoursesState with isLoading false and isLastPage true when loadNextPage is called and no courses are found',
    build: () => CoursesBloc(coursesRepository: mockCoursesRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const CoursesState(courses: [], isLoading: true),
      const CoursesState(courses: [], isLoading: false, isLastPage: true)
    ],
  );
}
