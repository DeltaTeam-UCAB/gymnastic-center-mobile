part of 'lessons_bloc.dart';

sealed class LessonsEvent{
  const LessonsEvent();
}

class LessonsLoaded extends LessonsEvent{
  final List<Lesson> lessons;
  final String selectedCourseId;
  final String imgSelectedCourse;

  const LessonsLoaded(this.lessons, this.selectedCourseId, this.imgSelectedCourse);
}

class CurrentLessonChanged extends LessonsEvent{
  final Lesson lesson;
  final bool isLastLesson;
  final bool isFirstLesson;

  const CurrentLessonChanged(this.lesson, this.isFirstLesson, this.isLastLesson);
}

class ErrorOcurred extends LessonsEvent{
  const ErrorOcurred();
}