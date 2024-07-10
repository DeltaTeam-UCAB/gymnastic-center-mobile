part of 'courses_suscriptions_bloc.dart';

enum CoursesSuscriptionsStatus { initial, loading, loaded, error}

class CoursesSuscriptionsState extends Equatable {

  final CoursesSuscriptionsStatus status;
  final List<CourseProgress> coursesSuscribed;
  final bool isLastPage;
  final int page;

  const CoursesSuscriptionsState({
    this.page = 0,
    this.isLastPage = false,
    this.status = CoursesSuscriptionsStatus.initial, 
    this.coursesSuscribed = const []
  });

  CoursesSuscriptionsState copyWith({
    List<CourseProgress>? coursesSuscribed,
    CoursesSuscriptionsStatus? status,
    int? page,
    bool? isLastPage
  })=>CoursesSuscriptionsState(
    coursesSuscribed: coursesSuscribed ?? this.coursesSuscribed,
    status: status ?? this.status,
    page: page ?? this.page,
    isLastPage: isLastPage ?? this.isLastPage,
  );
  
  @override
  List<Object> get props => [status, coursesSuscribed];
}

