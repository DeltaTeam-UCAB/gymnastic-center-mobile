import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

part 'trainers_event.dart';
part 'trainers_state.dart';

class TrainersBloc extends SafeBloc<TrainersEvent, TrainersState> {
  final TrainersRepository _trainersRepository;

  TrainersBloc(this._trainersRepository) : super(const TrainersState()) {
    on<TrainersLoaded>(_onTrainersLoaded);
    on<TrainerLoading>(_onTrainerLoading);
    on<TrainersIsEmpty>(_onTrainersIsEmpty);
    on<TrainerError>(_onTrainerError);
    on<RefreshTrainers>(_onRefreshTrainers);
  }

  void _onRefreshTrainers(RefreshTrainers event, Emitter<TrainersState> emit) {
    emit(const TrainersState());
    loadNextPage();
  }

  void _onTrainersLoaded(TrainersLoaded event, Emitter<TrainersState> emit) {
    emit(state.copyWith(
      trainers: [...state.trainers, ...event.trainers],
      status: TrainersStatus.loaded,
      page: state.page + 1,
    ));
  }

  void _onTrainerLoading(TrainerLoading event, Emitter<TrainersState> emit) {
    emit(state.copyWith(status: TrainersStatus.loading));
  }

  void _onTrainersIsEmpty(TrainersIsEmpty event, Emitter<TrainersState> emit) {
    emit(state.copyWith(status: TrainersStatus.loaded, isLastPage: true));
  }

  void _onTrainerError(TrainerError event, Emitter<TrainersState> emit) {
    emit(state.copyWith(status: TrainersStatus.error));
  }

  Future<void> loadNextPage([filterByFollowed = false]) async {
    if (state.status == TrainersStatus.loading || state.isLastPage) return;
    add(TrainerLoading());
    final result = await _trainersRepository.getTrainersPaginated(
      page: state.page,
      perPage: state.perPage,
      filterByFollowed: filterByFollowed,
    );

    if (result.isSuccessful()) {
      final trainers = result.getValue();
      if (trainers.isEmpty) {
        add(TrainersIsEmpty());
        return;
      }

      add(TrainersLoaded(trainers));
      return;
    }

    add(TrainerError());
  }

  void refreshTrainers() => add(RefreshTrainers());
}
