part of 'trending_progress_bloc.dart';




enum TrendingProgressStatus {loading, loaded, error}
class TrendingProgressState extends Equatable {
  final TrendingProgressStatus status;
  final CourseProgress trendingCourseProgress;

  const TrendingProgressState({
    required this.trendingCourseProgress,
    this.status = TrendingProgressStatus.loading
  });
  
  TrendingProgressState copyWith({
    TrendingProgressStatus? status,
    CourseProgress? trendingCourseProgress,
  })=>TrendingProgressState(
    status: status ?? this.status,
    trendingCourseProgress: trendingCourseProgress ?? this.trendingCourseProgress
  );

  @override
  List<Object> get props => [status, trendingCourseProgress];
}

