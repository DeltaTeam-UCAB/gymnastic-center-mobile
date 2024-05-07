part of 'courses_bloc.dart';

sealed class CoursesEvent {
  const CoursesEvent();
}

class CoursesFetched extends CoursesEvent {
  final List<Course> courses;
  const CoursesFetched(this.courses);
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

class CurrentCourse extends CoursesEvent {
  final Course? course;
  const CurrentCourse(this.course);
}
