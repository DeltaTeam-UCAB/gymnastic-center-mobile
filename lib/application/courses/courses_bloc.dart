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
    on<CoursesLoaded>(_onCoursesLoaded);
    on<CourseLoading>(_onCourseLoading);
    on<CoursesIsEmpty>(_onCourseIsEmpty);
    on<CourseError>(_onCourseError);
  }

  void _onCourseError(CourseError event, Emitter<CoursesState> emit) {
    emit(state.copyWith(isError: true, isLoading: false));
  }

  void _onCourseIsEmpty(CoursesIsEmpty event, Emitter<CoursesState> emit) {
    emit(state.copyWith(isLastPage: true, isLoading: false));
  }

  void _onCourseLoading(CourseLoading event, Emitter<CoursesState> emit) {
    emit(state.copyWith(isLoading: true, isError: false));
  }

  void _onCoursesLoaded(CoursesLoaded event, Emitter<CoursesState> emit) {
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
      add(CoursesLoaded(courses));
      return;
    }
    add(const CourseError());
  }
}
