part of 'follow_trainer_bloc.dart';

sealed class FollowTrainerEvent {
  const FollowTrainerEvent();
}

class FollowSuccess extends FollowTrainerEvent {}
class FollowLoading extends FollowTrainerEvent {}
class FollowError extends FollowTrainerEvent {}
