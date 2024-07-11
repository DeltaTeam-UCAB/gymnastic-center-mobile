import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/profile/profile_bloc.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

import '../suscriptions/utils/mock_suscription_repository.dart';
import '../trainers/utils/trainer_mock_repository.dart';

void main() {
  late TrainersRepository mockTrainersRepository;
  late SuscriptionRepository mockSuscriptionRepository;

  setUp(() {
    mockTrainersRepository = MockTrainerRepository([]);
    mockSuscriptionRepository = MockSuscriptionRepository([]);
  });

  blocTest(
    'Should emit ProfileState with isLoading true and show profile values when loadProfileData() is called',
    build: () => ProfileBloc(
        suscriptionRepository: mockSuscriptionRepository,
        trainersRepository: mockTrainersRepository),
    act: (bloc) => bloc.loadProfileData(),
    expect: () => [
      const ProfileState(isLoading: true),
      const ProfileState(
          followingTrainers: 5, suscribedCourses: 10, isLoading: false)
    ],
  );
}
