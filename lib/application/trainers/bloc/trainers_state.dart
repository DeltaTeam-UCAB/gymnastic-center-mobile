part of 'trainers_bloc.dart';

enum TrainersStatus { initial, loading, loaded, error }

class TrainersState extends Equatable {
  final List<TrainerDetails> trainers;
  final bool isLastPage;
  final TrainersStatus status;
  final int page;
  final int perPage;

  const TrainersState({
    this.trainers = const [],
    this.isLastPage = false,
    this.status = TrainersStatus.initial,
    this.page = 1,
    this.perPage = 10,
  });

  TrainersState copyWith({
    List<TrainerDetails>? trainers,
    bool? isLastPage,
    TrainersStatus? status,
    int? page,
    int? perPage,
  }) {
    return TrainersState(
      trainers: trainers ?? this.trainers,
      isLastPage: isLastPage ?? this.isLastPage,
      status: status ?? this.status,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }

  @override
  List<Object> get props => [
        trainers,
        isLastPage,
        status,
        page,
        perPage,
      ];
}
