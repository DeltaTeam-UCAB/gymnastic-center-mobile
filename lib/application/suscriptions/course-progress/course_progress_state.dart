part of 'course_progress_bloc.dart';

enum CourseProgressStatus {
  loading,
  loaded,
  error
}
const  initialLessonProgress = LessonsProgress(lessonId: '', percent: 0, time: Duration(seconds: 0));
class CourseProgressState extends Equatable {
  final CourseProgressStatus status;
  final int coursePercent;
  final List<LessonsProgress> lessonsProgress;
  
  const CourseProgressState({
    this.coursePercent = 0,
    this.lessonsProgress = const [],
    this.status = CourseProgressStatus.loading,
  });
  
  CourseProgressState copyWith({
    CourseProgressStatus? status,
    int? coursePercent,
    List<LessonsProgress>? lessonsProgress,
    LessonsProgress? currentLessonProgress
  })=>CourseProgressState(
    status: status ?? this.status,
    coursePercent: coursePercent ?? this.coursePercent,
    lessonsProgress: lessonsProgress ?? this.lessonsProgress,
  );
  
  @override
  List<Object> get props => [status, coursePercent, lessonsProgress];
}

