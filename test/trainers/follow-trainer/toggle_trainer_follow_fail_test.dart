import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/trainers/follow-trainer/follow_trainer_bloc.dart';
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
        trainer: mockTrainer, courseCount: 0, blogCount: 0, isFollowing: true);
    mockTrainerRepository =
        MockTrainerRepository([mockTrainerDetails], shouldFail: true);
  });

  blocTest(
    'Should emit FollowTrainerState with state [FollowTrainerStatus.error] when toggleFollow is called and something went wrong',
    build: () => FollowTrainerBloc(mockTrainerRepository),
    act: (bloc) => bloc.toggleFollow('1'),
    expect: () => [
      const FollowTrainerState(status: FollowTrainerStatus.loading),
      const FollowTrainerState(status: FollowTrainerStatus.error),
    ],
  );
}
