part of 'trainer_details_bloc.dart';

sealed class TrainerDetailsEvent {
  const TrainerDetailsEvent();
}

class LoadTrainer extends TrainerDetailsEvent {
  LoadTrainer();
}

class CurrentTrainer extends TrainerDetailsEvent {
  final Trainer trainer;
  final bool isFollowing;
  final int courseCount;
  final int blogCount;

  CurrentTrainer(
      {required this.trainer,
      required this.isFollowing,
      required this.courseCount,
      required this.blogCount});
}

class TrainerError extends TrainerDetailsEvent {
  TrainerError();
}

class UpdateFollowers extends TrainerDetailsEvent {
  final bool isFollowing;
  UpdateFollowers(this.isFollowing);
}
