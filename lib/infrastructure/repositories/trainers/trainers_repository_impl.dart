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
}
