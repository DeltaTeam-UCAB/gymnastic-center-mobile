part of 'trainers_bloc.dart';

sealed class TrainersEvent{
  const TrainersEvent();
}

class TrainersLoaded extends TrainersEvent{
  final List<TrainerDetails> trainers;
  const TrainersLoaded(this.trainers);
}

class TrainerLoading extends TrainersEvent{}

class TrainersIsEmpty extends TrainersEvent{}

class TrainerError extends TrainersEvent{}

class RefreshTrainers extends TrainersEvent{}
