part of 'courses_bloc.dart';

class CoursesState extends Equatable {
  final List<Course> courses;
  final Course? currentCourse;
  final bool isLoading;
  final int limit;
  final int offset;
  final bool isLastPage;
  final bool isError;

  const CoursesState({
    this.currentCourse,
    this.courses = const [],
    this.isLoading = false,
    this.limit = 10,
    this.offset = 0,
    this.isLastPage = false,
    this.isError = false,
  });

  CoursesState copyWith({
    List<Course>? courses,
    Course? currentCourse,
    bool? isLoading,
    int? limit,
    int? offset,
    bool? isLastPage,
    bool? isError,
  }) {
    return CoursesState(
      courses: courses ?? this.courses,
      currentCourse: currentCourse ?? this.currentCourse,
      isLoading: isLoading ?? this.isLoading,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      isLastPage: isLastPage ?? this.isLastPage,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props =>
      [courses, isLoading, limit, offset, isLastPage, isError];
}
