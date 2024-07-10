part of 'delete_course_bloc.dart';

enum DeleteCourseStatus { initial, deleting, error }
class DeleteCourseState extends Equatable {
  final DeleteCourseStatus status;
  const DeleteCourseState({
    this.status = DeleteCourseStatus.initial
  });
  
  DeleteCourseState copyWith({
    DeleteCourseStatus? status
  })=> DeleteCourseState(
      status: status ?? this.status
    );

  @override
  List<Object> get props => [status];
}

