part of 'suscribed_courses_bloc.dart';

sealed class SuscribedCoursesEvent{
  const SuscribedCoursesEvent();
}


class StartLoadingNextPage extends SuscribedCoursesEvent{

}

class SuscribedCouresesLoaded extends SuscribedCoursesEvent{
  final List<CourseProgress> coursesSuscribed;
  final bool isLastPage;
  final int page;
  SuscribedCouresesLoaded({required this.coursesSuscribed, required this.isLastPage, required this.page});
}

class CoursesUnsuscribed extends SuscribedCoursesEvent{}

class ErrorOccurred  extends SuscribedCoursesEvent{}
