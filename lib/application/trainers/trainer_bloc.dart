import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

part 'trainer_event.dart';
part 'trainer_state.dart';

final initialTrainer = Trainer(
  id: '',
  name: '',
  location: '',
  followers: 0,
);

class TrainerBloc extends Bloc<TrainerEvent, TrainerState> {
  final TrainersRepository trainersRepository;

  TrainerBloc(this.trainersRepository)
      : super(TrainerState(trainer: initialTrainer)) {
    on<LoadTrainer>(_onLoadTrainer);
    on<CurrentTrainer>(_onCurrentTrainer);
    on<TrainerError>(_onTrainerError);
    on<ToggleFollow>(_onToggleFollow);
  }

  void _onToggleFollow(ToggleFollow event, Emitter<TrainerState> emit) {
    emit(state.copyWith(
      isLoading: false,
      isFollowing: event.isFollowing,
      trainer: state.trainer.copyWith(
          followers: state.trainer.followers + (event.isFollowing ? 1 : -1)),
    ));
  }

  void _onTrainerError(TrainerError event, Emitter<TrainerState> emit) {
    emit(state.copyWith(isLoading: false, isError: true));
  }

  void _onCurrentTrainer(CurrentTrainer event, Emitter<TrainerState> emit) {
    emit(state.copyWith(
      trainer: event.trainer,
      isFollowing: event.isFollowing,
      isLoading: false,
      isError: false,
    ));
  }

  void _onLoadTrainer(LoadTrainer event, Emitter<TrainerState> emit) {
    emit(state.copyWith(isLoading: true, isError: false));
  }

  Future<void> loadTrainer(String trainerId) async {
    if (state.isLoading || state.isError) return;
    add(LoadTrainer());
    final trainerResponse = await trainersRepository.getTrainerById(trainerId);

    if (trainerResponse.isSuccessful()) {
      final trainerDetails = trainerResponse.getValue();
      add(CurrentTrainer(trainerDetails.trainer, trainerDetails.isFollowing));
      return;
    }
    add(TrainerError());
  }

  Future<void> toggleFollow() async {
    if (state.isError) return;
    final response = await trainersRepository.toggleFollow(state.trainer.id);
    if (response.isSuccessful()) {
      final isFollowing = response.getValue();
      add(ToggleFollow(isFollowing));
      return;
    }
    add(TrainerError());
  }
}
