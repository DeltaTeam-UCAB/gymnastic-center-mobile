import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

part 'suscribe_course_event.dart';
part 'suscribe_course_state.dart';

class SuscribeCourseBloc extends SafeBloc<SuscribeCourseEvent, SuscribeCourseState> {
  final SuscriptionRepository suscriptionRepository;
  SuscribeCourseBloc(this.suscriptionRepository) : super(const SuscribeCourseState()) {
    on<SuscribedStatusChecked>(_onSuscribedStatusChecked);
  }

  void _onSuscribedStatusChecked(SuscribedStatusChecked event, Emitter<SuscribeCourseState> emit){
    emit(
      state.copyWith(
        status: event.status
      )
    );
  }

  Future<void> checkSuscriptionCourse(String courseId) async{
    final result = await suscriptionRepository.getProgressByCourseId(courseId);
    if (result.isSuccessful()){
      add(SuscribedStatusChecked(SuscribedStatus.suscribed));
      return ;
    }
    add(SuscribedStatusChecked(SuscribedStatus.unsuscribed));
  }

  Future<void> suscribeToCourse(String courseId) async{
    final result = await suscriptionRepository.suscribeToCourse(courseId);
    if (result.isSuccessful()){
      add(SuscribedStatusChecked(SuscribedStatus.suscribed));
      return ;
    }
    add(SuscribedStatusChecked(SuscribedStatus.unsuscribed));
  }

}
