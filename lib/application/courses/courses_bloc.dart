import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final CoursesRepository coursesRepository;

  CoursesBloc({
    required this.coursesRepository,
  }) : super(const CoursesState()) {
    on<CoursesFetched>(_onCoursesFetched);
    on<CourseLoading>(_onCourseLoading);
    on<CoursesIsEmpty>(_onCourseIsEmpty);
    on<CourseError>(_onCourseError);
    on<CurrentCourse>(_onCurrentCourse);
  }

  void _onCurrentCourse(CurrentCourse event, Emitter<CoursesState> emit) {
    emit(state.copyWith(currentCourse: event.course, isLoading: false));
  }

  void _onCourseError(CourseError event, Emitter<CoursesState> emit) {
    emit(state.copyWith(isError: true));
  }

  void _onCourseIsEmpty(CoursesIsEmpty event, Emitter<CoursesState> emit) {
    emit(state.copyWith(isLastPage: true));
  }

  void _onCourseLoading(CourseLoading event, Emitter<CoursesState> emit) {
    emit(state.copyWith(isLoading: true, isError: false));
  }

  void _onCoursesFetched(CoursesFetched event, Emitter<CoursesState> emit) {
    emit(state.copyWith(
      courses: [...state.courses, ...event.courses],
      isLoading: false,
      page: state.page + 1,
    ));
  }

  Future<void> loadNextPage(
      {CourseFilter filter = CourseFilter.recent,
      String? categoryId,
      String? trainerId}) async {
    if (state.isLastPage || state.isLoading || state.isError) return;
    add(const CourseLoading());

    final coursesResponse = await coursesRepository.getCoursesPaginated(
      page: state.page,
      perPage: state.perPage,
      filter: filter,
      category: categoryId,
      trainer: trainerId,
    );

    if (coursesResponse.isSuccessful()) {
      final courses = coursesResponse.getValue();
      if (courses.isEmpty) {
        add(const CoursesIsEmpty());
        return;
      }
      add(CoursesFetched(courses));
      return;
    }
    add(const CourseError());
  }

  Future<void> getCourseById(String courseId) async {
    add(const CourseLoading());
    final courseResponse = await coursesRepository.getCourseById(courseId);

    if (courseResponse.isSuccessful()) {
      final course = courseResponse.getValue();
      add(CurrentCourse(course));
      return;
    }

    add(const CurrentCourse(null));
    add(const CourseError());
  }
}
