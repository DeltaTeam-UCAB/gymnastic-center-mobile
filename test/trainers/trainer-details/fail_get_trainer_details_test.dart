import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/trainers/trainer-details/trainer_details_bloc.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

import '../utils/trainer_mock_repository.dart';

void main() {
  late TrainersRepository mockTrainerRepository;
  
  setUp(() {
    mockTrainerRepository = MockTrainerRepository([], shouldFail: true);
  });

  blocTest(
    'Should emit TrainerState with isError true when LoadTrainer is called and trainer not found', 
    build: () => TrainerDetailsBloc(mockTrainerRepository),
    act: (bloc) => bloc.loadTrainer('2'),
    expect: () => [
      isA<TrainerDetailsState>()
          .having((state) => state.isLoading, 'isLoading', true)
          .having((state) => state.isError, 'isError', false)
          .having((state) => state.trainer, 'trainer', initialTrainer),
      isA<TrainerDetailsState>()
          .having((state) => state.isLoading, 'isLoading', false)
          .having((state) => state.isError, 'isError', true)
          .having((state) => state.trainer, 'trainer', initialTrainer),
    ],
  );
}
