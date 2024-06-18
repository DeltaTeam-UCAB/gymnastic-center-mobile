part of 'courses_bloc.dart';

class CoursesState extends Equatable {
  final List<Course> courses;
  final bool isLoading;
  final int page;
  final int perPage;
  final bool isLastPage;
  final bool isError;

  const CoursesState({
    this.courses = const [],
    this.isLoading = false,
    this.page = 1,
    this.perPage = 10,
    this.isLastPage = false,
    this.isError = false,
  });

  CoursesState copyWith({
    List<Course>? courses,
    bool? isLoading,
    int? page,
    int? perPage,
    bool? isLastPage,
    bool? isError,
  }) {
    return CoursesState(
      courses: courses ?? this.courses,
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      isLastPage: isLastPage ?? this.isLastPage,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props =>
      [courses, isLoading, page, perPage, isLastPage, isError];
}
