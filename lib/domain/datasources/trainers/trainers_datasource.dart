import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';

class TrainerDetails {
  final Trainer trainer;
  final bool isFollowing;
  final int courseCount;
  final int blogCount;

  TrainerDetails({
    required this.trainer,
    required this.isFollowing,
    this.courseCount = 0,
    this.blogCount = 0,
  });
}

abstract class TrainersDataSource {
  Future<TrainerDetails> getTrainerById(String trainerId);
  Future<bool> toggleFollow(String trainerId);
  Future<List<TrainerDetails>> getTrainersPaginated({
    int page = 1,
    int perPage = 10,
    bool filterByFollowed = false,
  });
  Future<String> deleteTrainer(String trainerId);
  Future<int> getFollowingTrainersCount();
}
