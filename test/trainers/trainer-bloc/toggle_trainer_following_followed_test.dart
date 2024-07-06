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
    mockTrainerRepository = MockTrainerRepository(mockTrainer, true);
  });

  blocTest(
    'Should emit TrainerState with isFollowing true when ToggleFollow is called',
    build: () => TrainerBloc(mockTrainerRepository),
    act: (bloc) {
      bloc.loadTrainer('1');
      bloc.toggleFollow();
    },
    expect: () => [
      isA<TrainerState>()
          .having((state) => state.isLoading, 'isLoading', true)
          .having((state) => state.trainer, 'trainer', initialTrainer),
      isA<TrainerState>()
          .having((state) => state.isLoading, 'isLoading', false)
          .having((state) => state.isFollowing, 'isFollowing', false)
          .having((state) => state.trainer, 'trainer', mockTrainer),
      isA<TrainerState>()
          .having((state) => state.isFollowing, 'isFollowing', true)
          .having((state) => state.trainer.followers, 'followers', 101),
    ],
  );
}
