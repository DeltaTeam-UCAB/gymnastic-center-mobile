part of 'courses_bloc.dart';

sealed class CoursesEvent {
  const CoursesEvent();
}

class CoursesLoaded extends CoursesEvent {
  final List<Course> courses;
  const CoursesLoaded(this.courses);
}

class CourseLoading extends CoursesEvent {
  const CourseLoading();
}

class CoursesIsEmpty extends CoursesEvent {
  const CoursesIsEmpty();
}

class CourseError extends CoursesEvent {
  const CourseError();
}
