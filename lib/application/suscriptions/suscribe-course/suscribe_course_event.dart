part of 'suscribe_course_bloc.dart';

sealed class SuscribeCourseEvent {
  const SuscribeCourseEvent();
}

class SuscribedStatusChecked extends SuscribeCourseEvent{
  final SuscribedStatus status;
  SuscribedStatusChecked(this.status);
}
