import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

part 'delete_lesson_event.dart';
part 'delete_lesson_state.dart';

class DeleteLessonBloc extends SafeBloc<DeleteLessonEvent, DeleteLessonState> {
  final CoursesRepository _coursesRepository;
  DeleteLessonBloc(this._coursesRepository) : super(const DeleteLessonState()) {
    on<DeleteLessonStarted>(_onDeleteLessonStarted);
    on<LessonDeleted>(_onLessonDeleted);
    on<ErrorOccurred>(_onErrorOccurred);
  }
  void _onDeleteLessonStarted(
      DeleteLessonStarted event, Emitter<DeleteLessonState> emit) {
    emit(state.copyWith(
      status: DeleteLessonStatus.deleting,
    ));
  }

  void _onLessonDeleted(LessonDeleted event, Emitter<DeleteLessonState> emit) {
    emit(state.copyWith(
      status: DeleteLessonStatus.deleted,
    ));
  }

  void _onErrorOccurred(ErrorOccurred event, Emitter<DeleteLessonState> emit) {
    emit(state.copyWith(
      status: DeleteLessonStatus.error,
    ));
  }

  Future<void> deleteLesson(
      {required String courseId, required String lessonId}) async {
    add(DeleteLessonStarted());
    final deleteCourseResult =
        await _coursesRepository.deleteLesson(courseId, lessonId);
    if (deleteCourseResult.isSuccessful()) {
      add(LessonDeleted());
    } else {
      add(ErrorOccurred());
    }
  }
}
