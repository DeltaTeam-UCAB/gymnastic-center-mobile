part of 'delete_trainer_bloc.dart';


enum DeleteTrainerStatus { initial, deleting, deleted ,error }
class DeleteTrainerState extends Equatable {
  final DeleteTrainerStatus status;
  const DeleteTrainerState({
    this.status = DeleteTrainerStatus.initial,
  });
  
  DeleteTrainerState copyWith({
    DeleteTrainerStatus? status,
  }) => DeleteTrainerState(
    status: status ?? this.status,
  );

  @override
  List<Object> get props => [status];
}
