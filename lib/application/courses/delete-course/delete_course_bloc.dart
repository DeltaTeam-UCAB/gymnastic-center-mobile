import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

part 'delete_course_event.dart';
part 'delete_course_state.dart';

class DeleteCourseBloc extends SafeBloc<DeleteCourseEvent, DeleteCourseState> {

  final CoursesRepository _coursesRepository;
  DeleteCourseBloc(this._coursesRepository) : super(const DeleteCourseState()) {
    on<DeleteCourseStarted>(_onDeleteCourseStarted);
    on<CourseDeleted>(_onCourseDeleted);
    on<ErrorOccurred>(_onErrorOccurred);
  }
  void _onDeleteCourseStarted(DeleteCourseStarted event, Emitter<DeleteCourseState> emit){
    emit(
      state.copyWith(
        status: DeleteCourseStatus.deleting,
      )
    );
  }

  void _onCourseDeleted(CourseDeleted event, Emitter<DeleteCourseState> emit){
    emit(
      state.copyWith(
        status: DeleteCourseStatus.deleted,
      )
    );
  }

  void _onErrorOccurred(ErrorOccurred event, Emitter<DeleteCourseState> emit){
    emit(
      state.copyWith(
        status: DeleteCourseStatus.error,
      )
    );
  }

  Future<void> deleteCourse(String courseId) async {
    add(DeleteCourseStarted());
    final deleteCourseResult = await _coursesRepository.deleteCourse(courseId);
    if ( deleteCourseResult.isSuccessful() ){
      add(CourseDeleted());
      return;
    }
    add(ErrorOccurred());
  }
  
}
