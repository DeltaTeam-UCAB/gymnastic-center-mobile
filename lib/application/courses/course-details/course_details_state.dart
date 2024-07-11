part of 'course_details_bloc.dart';

enum CourseDetailsStatus { initial, loading, error, loaded }

class CourseDetailsState extends Equatable {
  final Course course;
  final CourseDetailsStatus status;

  const CourseDetailsState(
      {required this.course, this.status = CourseDetailsStatus.initial});

  CourseDetailsState copyWith({
    Course? course,
    CourseDetailsStatus? status,
  }) =>
      CourseDetailsState(
        course: course ?? this.course,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [course, status];
}
