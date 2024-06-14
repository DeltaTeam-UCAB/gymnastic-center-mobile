part of 'trainer_bloc.dart';

sealed class TrainerEvent {
  const TrainerEvent();
}

class LoadTrainer extends TrainerEvent {
  LoadTrainer();
}

class CurrentTrainer extends TrainerEvent {
  final Trainer trainer;
  final bool isFollowing;

  CurrentTrainer(this.trainer, this.isFollowing);
}

class ToggleFollow extends TrainerEvent {
  final bool isFollowing;
  ToggleFollow(this.isFollowing);
}

class TrainerError extends TrainerEvent {
  TrainerError();
}

