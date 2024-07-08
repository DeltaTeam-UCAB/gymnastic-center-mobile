import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/trainers/trainer-details/trainer_details_bloc.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

import '../utils/trainer_mock_repository.dart';

void main() {
  late TrainersRepository mockTrainerRepository;
  late Trainer mockTrainer;
  late TrainerDetails mockTrainerDetails;

  setUp(() {
    mockTrainer = Trainer(
        id: '1',
        name: 'John Doe',
        location: 'Jakarta',
        followers: 100,
        image: 'image');
    mockTrainerDetails = TrainerDetails(
        trainer: mockTrainer,
        isFollowing: false,
        blogCount: 10,
        courseCount: 10);
    mockTrainerRepository = MockTrainerRepository([mockTrainerDetails]);
  });

  blocTest(
    'Should emit TrainerState with Trainer followers changed when updateFollowers is called',
    build: () => TrainerDetailsBloc(mockTrainerRepository),
    act: (bloc) async {
      await bloc.loadTrainer('1');
      bloc.updateFollowers(true);
    },
    expect: () => [
      TrainerDetailsState(isLoading: true, trainer: initialTrainer),
      TrainerDetailsState(
          isLoading: false,
          trainer: mockTrainer,
          blogCount: 10,
          courseCount: 10,
          isFollowing: false),
      isA<TrainerDetailsState>()
          .having((state) => state.trainer.followers, 'followers', 101)
          .having((state) => state.isFollowing, 'isFollowing', true),
    ],
  );
}
