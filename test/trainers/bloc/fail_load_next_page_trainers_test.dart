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
    trainerMock = Trainer(id: '1', name: 'name', location: 'location', image: 'image');
    trainerDetailsMock = TrainerDetails(trainer: trainerMock, isFollowing: false);
    mockTrainersRepository = MockTrainerRepository([trainerDetailsMock], shouldFail: true);
  });

  blocTest(
    'Should emit TrainerState with status [TrainerStatus.error]',
    build: () => TrainersBloc(mockTrainersRepository),
    act: (bloc) => bloc.loadNextPage(),
    expect: () => [
      const TrainersState(trainers: [], status: TrainersStatus.loading),
      const TrainersState(trainers: [], status: TrainersStatus.error),
    ],
  );
}
