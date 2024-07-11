part of 'delete_course_bloc.dart';

sealed class DeleteCourseEvent{
  const DeleteCourseEvent();
}
class DeleteCourseStarted extends DeleteCourseEvent{}
class CourseDeleted extends DeleteCourseEvent{}
class ErrorOccurred extends DeleteCourseEvent{}

