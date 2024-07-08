import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/trainers/bloc/trainers_bloc.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

import '../utils/trainer_mock_repository.dart';

void main() {
  late TrainersRepository mockTrainersRepository;
  late Trainer trainerMock;
  late TrainerDetails trainerDetailsMock;

  setUp(() {
    trainerMock =
        Trainer(id: '1', name: 'name', location: 'location', image: 'image');
    trainerDetailsMock =
        TrainerDetails(trainer: trainerMock, isFollowing: false);
    mockTrainersRepository =
        MockTrainerRepository([trainerDetailsMock], shouldFail: false);
  });

  blocTest(
      'Should emit TrainerState with isLoading false and trainers [trainers] when loadNextPage is called',
      build: () => TrainersBloc(mockTrainersRepository),
      act: (bloc) => bloc.loadNextPage(),
      expect: () => [
            const TrainersState(trainers: [], status: TrainersStatus.loading),
            isA<TrainersState>()
                .having((state) => state.trainers.first.trainer, 'trainers',
                    trainerMock)
                .having(
                    (state) => state.status, 'status', TrainersStatus.loaded)
          ]);
}
