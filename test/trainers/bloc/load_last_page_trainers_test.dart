import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/trainers/bloc/trainers_bloc.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

import '../utils/trainer_mock_repository.dart';

void main() {
  late TrainersRepository mockTrainersRepository;

  setUp(() {
    mockTrainersRepository = MockTrainerRepository([], shouldFail: false);
  });

  blocTest(
    'Should emit TrainerState with status [TrainerStatus.loaded] when loadNextPage is called',
    build: () => TrainersBloc(mockTrainersRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const TrainersState(trainers: [], status: TrainersStatus.loading),
      const TrainersState(trainers: [], status: TrainersStatus.loaded, isLastPage: true),
    ],
  );
}
