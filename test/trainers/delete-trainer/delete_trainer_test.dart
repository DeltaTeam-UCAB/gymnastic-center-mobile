import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/trainers/delete-trainer/delete_trainer_bloc.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';

import '../utils/trainer_mock_repository.dart';


void main() {
  late MockTrainerRepository mockTrainerRepository;
  late List<TrainerDetails> mockTrainers;
  setUp(() {
    
    mockTrainers = [
      TrainerDetails(
        trainer: Trainer(id: '1', name: 'name', location: 'location', image: 'image'),
        isFollowing: false
      ),
    ];
    mockTrainerRepository = MockTrainerRepository(mockTrainers);
  });

  blocTest(
      'Should emit DeleteTrainerState with status deleting and refresh when deleteTrainer is called',
      build: () => DeleteTrainerBloc(mockTrainerRepository),
      act: (bloc) => bloc.deleteTrainer('1'),
      verify: (_) {
        expect(mockTrainerRepository.trainers.length, 0);
      },
      expect: () => [
        isA<DeleteTrainerState>()
          .having((state) => state.status, 'status', DeleteTrainerStatus.deleting),
        isA<DeleteTrainerState>()
          .having((state) => state.status, 'status', DeleteTrainerStatus.initial),
      ]);
}
 