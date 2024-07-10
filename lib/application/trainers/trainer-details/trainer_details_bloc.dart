import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

part 'trainer_details_event.dart';
part 'trainer_details_state.dart';

final initialTrainer = Trainer(
  id: '',
  name: '',
  location: '',
  followers: 0,
  image: '',
);

class TrainerDetailsBloc
    extends SafeBloc<TrainerDetailsEvent, TrainerDetailsState> {
  final TrainersRepository trainersRepository;

  TrainerDetailsBloc(this.trainersRepository)
      : super(TrainerDetailsState(trainer: initialTrainer)) {
    on<LoadTrainer>(_onLoadTrainer);
    on<CurrentTrainer>(_onCurrentTrainer);
    on<TrainerError>(_onTrainerError);
    on<UpdateFollowers>(_onUpdateFollowers);
  }

  void _onUpdateFollowers(
      UpdateFollowers event, Emitter<TrainerDetailsState> emit) {
    emit(state.copyWith(
        trainer: state.trainer.copyWith(
            followers: event.isFollowing
                ? state.trainer.followers + 1
                : state.trainer.followers - 1),
        isFollowing: event.isFollowing));
  }

  void _onTrainerError(TrainerError event, Emitter<TrainerDetailsState> emit) {
    emit(state.copyWith(isLoading: false, isError: true));
  }

  void _onCurrentTrainer(
      CurrentTrainer event, Emitter<TrainerDetailsState> emit) {
    emit(state.copyWith(
      trainer: event.trainer,
      courseCount: event.courseCount,
      blogCount: event.blogCount,
      isLoading: false,
      isError: false,
    ));
  }

  void _onLoadTrainer(LoadTrainer event, Emitter<TrainerDetailsState> emit) {
    emit(state.copyWith(isLoading: true, isError: false));
  }

  Future<void> loadTrainer(String trainerId) async {
    if (state.isLoading || state.isError) return;
    add(LoadTrainer());
    final trainerResponse = await trainersRepository.getTrainerById(trainerId);

    if (trainerResponse.isSuccessful()) {
      final trainerDetails = trainerResponse.getValue();
      add(CurrentTrainer(
        trainer: trainerDetails.trainer,
        isFollowing: trainerDetails.isFollowing,
        courseCount: trainerDetails.courseCount,
        blogCount: trainerDetails.blogCount,
      ));
      return;
    }
    add(TrainerError());
  }

  void updateFollowers(bool isFollowing) {
    if (isFollowing == state.isFollowing) return;
    add(UpdateFollowers(isFollowing));
  }
}
