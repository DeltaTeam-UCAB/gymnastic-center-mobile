import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

part 'follow_trainer_event.dart';
part 'follow_trainer_state.dart';

class FollowTrainerBloc extends SafeBloc<FollowTrainerEvent, FollowTrainerState> {
  final TrainersRepository trainerRepository;
  FollowTrainerBloc(this.trainerRepository) : super(const FollowTrainerState()) {
    on<FollowLoading>(_onFollowLoading);
    on<FollowSuccess>(_onFollowSuccess);
    on<FollowError>(_onFollowError);
  }

  void _onFollowLoading(FollowLoading event, Emitter<FollowTrainerState> emit) {
    emit(state.copyWith(status: FollowTrainerStatus.loading));
  }

  void _onFollowSuccess(FollowSuccess event, Emitter<FollowTrainerState> emit) {
    emit(state.copyWith(status: FollowTrainerStatus.success));
  }

  void _onFollowError(FollowError event, Emitter<FollowTrainerState> emit) {
    emit(state.copyWith(status: FollowTrainerStatus.error));
  }

  Future<bool> toggleFollow(String trainerId) async {
    if (state.status == FollowTrainerStatus.loading) return false;
    add(FollowLoading());
    final result = await trainerRepository.toggleFollow(trainerId);
    if (result.isSuccessful()){
      add(FollowSuccess());
      return true;
    } else {
      add(FollowError());
      return false;
    }
  }
}