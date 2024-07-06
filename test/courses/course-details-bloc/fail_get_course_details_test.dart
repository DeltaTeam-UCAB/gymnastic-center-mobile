import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/courses/course-details/course_details_bloc.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

import '../utils/mock_courses_repository.dart';

void main() {
  late CoursesRepository mockCoursesRepository;
  setUp(() => mockCoursesRepository = MockCoursesRepository([]));

  blocTest(
    'Should emit CourseDetailsState with status loading and error when getCourseById is called and no courses are found',
    build: () => CourseDetailsBloc(mockCoursesRepository),
    act: (bloc) => bloc.getCourseById('1'),
    expect: () => [
      isA<CourseDetailsState>()
          .having(
              (state) => state.status, 'status', CourseDetailsStatus.loading)
          .having((state) => state.course, 'course', initialCourse),
      isA<CourseDetailsState>()
          .having((state) => state.status, 'status', CourseDetailsStatus.error)
          .having((state) => state.course, 'course', initialCourse)
    ],
  );
}
