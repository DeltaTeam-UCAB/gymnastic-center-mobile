part of 'delete_trainer_bloc.dart';

class DeleteTrainerEvent{
  const DeleteTrainerEvent();
}

class DeleteTrainerStarted extends DeleteTrainerEvent{}
class TrainerDeleted extends DeleteTrainerEvent{}
class ErrorOccurred extends DeleteTrainerEvent{}
