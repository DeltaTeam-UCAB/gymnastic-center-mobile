import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

class TrainersRepositoryImpl extends TrainersRepository {
  final TrainersDataSource trainersDataSource;

  TrainersRepositoryImpl(this.trainersDataSource);

  @override
  Future<Result<TrainerDetails>> getTrainerById(String trainerId) async {
    try {
      final trainer = await trainersDataSource.getTrainerById(trainerId);
      return Result<TrainerDetails>.success(trainer);
    } catch (error, _) {
      return Result<TrainerDetails>.fail(error as Exception);
    }
  }

  @override
  Future<Result<bool>> toggleFollow(String trainerId) async {
    try {
      final result = await trainersDataSource.toggleFollow(trainerId);
      return Result<bool>.success(result);
    } catch (error, _) {
      return Result<bool>.fail(error as Exception);
    }
  }

  @override
  Future<Result<List<TrainerDetails>>> getTrainersPaginated(
      {int page = 1, int perPage = 10, bool filterByFollowed = false}) async {
    try {
      final result = await trainersDataSource.getTrainersPaginated(
          page: page, perPage: perPage, filterByFollowed: filterByFollowed);
      return Result<List<TrainerDetails>>.success(result);
    } catch (e) {
      return Result<List<TrainerDetails>>.fail(e as Exception);
    }
  }
  
  @override
  Future<Result<String>> deleteTrainer(String trainerId) async{
    try {
      final trainerIdDeleted = await trainersDataSource.deleteTrainer(trainerId);
      return Result.success(trainerIdDeleted);
    } catch (e) {
      return Result.fail(e as Exception);
      
    }
  }
}
