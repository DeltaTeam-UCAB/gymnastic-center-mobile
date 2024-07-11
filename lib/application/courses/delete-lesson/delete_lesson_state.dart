part of 'delete_lesson_bloc.dart';

enum DeleteLessonStatus { initial, deleting, deleted, error }

class DeleteLessonState extends Equatable {
  final DeleteLessonStatus status;

  const DeleteLessonState({this.status = DeleteLessonStatus.initial});

  DeleteLessonState copyWith({DeleteLessonStatus? status}) =>
      DeleteLessonState(status: status ?? this.status);

  @override
  List<Object> get props => [status];
}
