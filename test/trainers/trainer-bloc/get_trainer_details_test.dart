import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/trainers/trainer_bloc.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

import '../utils/trainer_mock_repository.dart';

void main() {
  late TrainersRepository mockTrainerRepository;
  late Trainer mockTrainer;

  setUp(() {
    mockTrainer = Trainer(
      id: '1',
      name: 'John Doe',
      location: 'Jakarta',
      followers: 100,
    );
    mockTrainerRepository = MockTrainerRepository(mockTrainer);
  });

  blocTest(
    'Should emit TrainerState with isLoading true when LoadTrainer is called',
    build: () => TrainerBloc(mockTrainerRepository),
    act: (bloc) => bloc.loadTrainer('1'),
    expect: () => [
      isA<TrainerState>()
          .having((state) => state.isLoading, 'isLoading', true)
          .having((state) => state.isError, 'isError', false)
          .having((state) => state.trainer, 'trainer', initialTrainer),
      isA<TrainerState>()
          .having((state) => state.isLoading, 'isLoading', false)
          .having((state) => state.isError, 'isError', false)
          .having((state) => state.trainer, 'trainer', mockTrainer),
    ],
  );
}
