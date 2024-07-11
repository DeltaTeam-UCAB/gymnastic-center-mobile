part of 'delete_lesson_bloc.dart';

sealed class DeleteLessonEvent {
  const DeleteLessonEvent();
}

class DeleteLessonStarted extends DeleteLessonEvent {}

class LessonDeleted extends DeleteLessonEvent {}

class ErrorOccurred extends DeleteLessonEvent {}
