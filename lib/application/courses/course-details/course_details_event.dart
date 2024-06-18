part of 'course_details_bloc.dart';

class CourseDetailsEvent {
  const CourseDetailsEvent();
}

class CourseLoaded extends CourseDetailsEvent{
  final Course course;
  CourseLoaded({required this.course});
}

class LoadingStarted extends CourseDetailsEvent{}
class ErrorOnCourseLoading extends CourseDetailsEvent{}
