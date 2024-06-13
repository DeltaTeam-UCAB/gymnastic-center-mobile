import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';

abstract class TrainersRepository {
  Future<Result<TrainerDetails>> getTrainerById(String trainerId);
  Future<Result<bool>> toggleFollow(String trainerId);
}