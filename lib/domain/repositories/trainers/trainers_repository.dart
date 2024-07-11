import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';

abstract class TrainersRepository {
  Future<Result<TrainerDetails>> getTrainerById(String trainerId);
  Future<Result<bool>> toggleFollow(String trainerId);
  Future<Result<List<TrainerDetails>>> getTrainersPaginated({
    int page = 1,
    int perPage = 10,
    bool filterByFollowed = false,
  });
  Future<Result<String>> deleteTrainer(String trainerId);
  Future<Result<int>> getFollowingTrainersCount();
}
