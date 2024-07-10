import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

part 'delete_trainer_event.dart';
part 'delete_trainer_state.dart';

class DeleteTrainerBloc extends SafeBloc<DeleteTrainerEvent, DeleteTrainerState> {

  final TrainersRepository _trainerRepository;

  DeleteTrainerBloc(this._trainerRepository) : super(const DeleteTrainerState()) {
    on<DeleteTrainerStarted>(_onDeleteTrainerStarted);
    on<TrainerDeleted>(_onCourseDeleted);
    on<ErrorOccurred>(_onErrorOccurred);
  }
  void _onDeleteTrainerStarted(DeleteTrainerStarted event, Emitter<DeleteTrainerState> emit){
    emit(
      state.copyWith(
        status: DeleteTrainerStatus.deleting,
      )
    );
  }

  void _onCourseDeleted(TrainerDeleted event, Emitter<DeleteTrainerState> emit){
    emit(
      state.copyWith(
        status: DeleteTrainerStatus.initial,
      )
    );
  }

  void _onErrorOccurred(ErrorOccurred event, Emitter<DeleteTrainerState> emit){
    emit(
      state.copyWith(
        status: DeleteTrainerStatus.error,
      )
    );
  }

  Future<void> deleteTrainer(String trainerId) async {
    add(DeleteTrainerStarted());
    final deleteTrainerResult = await _trainerRepository.deleteTrainer(trainerId);
    if ( deleteTrainerResult.isSuccessful() ){
      add(TrainerDeleted());
      return;
    }
    add(ErrorOccurred());
  }
  


}
