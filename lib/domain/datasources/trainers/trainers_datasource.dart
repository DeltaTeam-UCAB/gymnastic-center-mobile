import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';

class TrainerDetails {
  final Trainer trainer;
  final bool isFollowing;

  TrainerDetails({required this.trainer, required this.isFollowing});
}

abstract class TrainersDataSource {
  Future<TrainerDetails> getTrainerById(String trainerId);
  Future<bool> toggleFollow(String trainerId);
}