part of 'suscribed_courses_bloc.dart';

enum SuscribedCoursesStatus { initial, loading, loaded, error}

class SuscribedCoursesState extends Equatable {

  final SuscribedCoursesStatus status;
  final List<CourseProgress> coursesSuscribed;
  final bool isLastPage;
  final int page;

  const SuscribedCoursesState({
    this.page = 0,
    this.isLastPage = false,
    this.status = SuscribedCoursesStatus.initial, 
    this.coursesSuscribed = const []
  });

  SuscribedCoursesState copyWith({
    List<CourseProgress>? coursesSuscribed,
    SuscribedCoursesStatus? status,
    int? page,
    bool? isLastPage
  })=>SuscribedCoursesState(
    coursesSuscribed: coursesSuscribed ?? this.coursesSuscribed,
    status: status ?? this.status,
    page: page ?? this.page,
    isLastPage: isLastPage ?? this.isLastPage,
  );
  
  @override
  List<Object> get props => [status, coursesSuscribed];
}

