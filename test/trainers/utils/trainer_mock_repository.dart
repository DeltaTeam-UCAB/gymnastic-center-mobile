import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';


class MockTrainerRepository extends TrainersRepository {

  final Trainer mockTrainer;
  final bool isFollowing;
  MockTrainerRepository(this.mockTrainer, [this.isFollowing = false]);

  @override
  Future<Result<TrainerDetails>> getTrainerById(String trainerId) {
    if (trainerId == mockTrainer.id) {
      return Future.value(Result.success(
          TrainerDetails(trainer: mockTrainer, isFollowing: !isFollowing)));
    }
    return Future.value(Result.fail(Exception('Trainer not found')));
  }

  @override
  Future<Result<bool>> toggleFollow(String trainerId) {
    return Future.value(Result.success(isFollowing));
  }
}
