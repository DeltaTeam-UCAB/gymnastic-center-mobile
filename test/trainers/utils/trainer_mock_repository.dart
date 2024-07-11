import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

class MockTrainerRepository extends TrainersRepository {
  final List<TrainerDetails> trainers;
  final bool isFollowing;
  final bool shouldFail;

  MockTrainerRepository(this.trainers,
      {this.isFollowing = false, this.shouldFail = false});

  @override
  Future<Result<TrainerDetails>> getTrainerById(String trainerId) {
    if (trainers.isNotEmpty) {
      final trainerDetails =
          trainers.firstWhere((element) => element.trainer.id == trainerId);
      return Future.value(Result.success(TrainerDetails(
          trainer: trainerDetails.trainer,
          blogCount: 10,
          courseCount: 10,
          isFollowing: isFollowing)));
    }
    return Future.value(Result.fail(Exception('No trainers found')));
  }

  @override
  Future<Result<bool>> toggleFollow(String trainerId) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('An error occurred')));
    }
    return Future.value(Result.success(!isFollowing));
  }

  @override
  Future<Result<List<TrainerDetails>>> getTrainersPaginated(
      {int page = 1, int perPage = 10, bool? filterByFollowed}) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('An error occurred')));
    }

    if (trainers.isEmpty) {
      return Future.value(Result.success([]));
    }

    return Future.value(Result.success(
        [TrainerDetails(trainer: trainers.first.trainer, isFollowing: false)]));
  }

  @override
  Future<Result<String>> deleteTrainer(String trainerId) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Failed to delete course')));
    }
    trainers.removeWhere((trainer) => trainer.trainer.id == trainerId);
    return Future.value(Result.success('course deleted'));
  }

  @override
  Future<Result<int>> getFollowingTrainersCount() {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Error loading profile')));
    }
    return Future.value(Result.success(5));
  }
}
