part of 'follow_trainer_bloc.dart';

enum FollowTrainerStatus { initial, loading, success, error }

class FollowTrainerState extends Equatable {
  final FollowTrainerStatus status;
  const FollowTrainerState({this.status = FollowTrainerStatus.initial});

  FollowTrainerState copyWith({FollowTrainerStatus? status}) =>
      FollowTrainerState(status: status ?? this.status);

  @override
  List<Object> get props => [status];
}
