part of 'course_progress_bloc.dart';

sealed class CourseProgressEvent {
  const CourseProgressEvent();
}

class CurrentCourseProgressLoaded extends CourseProgressEvent{
  final CourseProgress courseProgress;
  CurrentCourseProgressLoaded(this.courseProgress);
}

class CurrentCourseProgressEnded extends CourseProgressEvent{
  final int newPercent;
  final String lessonId;
  final int viewSeconds;
  CurrentCourseProgressEnded(this.newPercent, this.lessonId, this.viewSeconds);
}

class CurrentCourseProgressCompleted extends CourseProgressEvent{
  final String lessonId;
  CurrentCourseProgressCompleted(this.lessonId);
}

class CurrentLessonSelected extends CourseProgressEvent{
  final LessonsProgress lessonProgress;
  CurrentLessonSelected(this.lessonProgress);
}

class ErrorOccurred extends CourseProgressEvent{}