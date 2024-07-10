part of 'trending_progress_bloc.dart';

sealed class TrendingProgressEvent{
  const TrendingProgressEvent();
}


class TrendingCourseProgressLoaded extends TrendingProgressEvent{
  final CourseProgress courseProgress;
  TrendingCourseProgressLoaded(this.courseProgress);
}

class ErrorOccurred extends TrendingProgressEvent{
  ErrorOccurred();
}