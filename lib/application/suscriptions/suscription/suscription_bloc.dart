import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

part 'suscription_event.dart';
part 'suscription_state.dart';

class SuscriptionBloc extends SafeBloc<SuscriptionEvent, SuscriptionState> {
  final SuscriptionRepository suscriptionRepository;
  SuscriptionBloc(this.suscriptionRepository) : super(const SuscriptionState()) {
    on<SuscribedStatusChecked>(_onSuscribedStatusChecked);
  }

  void _onSuscribedStatusChecked(SuscribedStatusChecked event, Emitter<SuscriptionState> emit){
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
