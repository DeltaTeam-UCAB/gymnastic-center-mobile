part of 'courses_suscriptions_bloc.dart';

sealed class CoursesSuscriptionsEvent{
  const CoursesSuscriptionsEvent();
}


class StartLoadingNextPage extends CoursesSuscriptionsEvent{

}

class SuscribedCouresesLoaded extends CoursesSuscriptionsEvent{
  final List<CourseProgress> coursesSuscribed;
  final bool isLastPage;
  final int page;
  SuscribedCouresesLoaded({required this.coursesSuscribed, required this.isLastPage, required this.page});
}

class CoursesUnsuscribed extends CoursesSuscriptionsEvent{}

class ErrorOccurred  extends CoursesSuscriptionsEvent{}
