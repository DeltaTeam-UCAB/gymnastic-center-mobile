import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/infrastructure/models/trainer/trainer_response.dart';

class TrainerMapper {
  static Trainer trainerToEntity(TrainerResponse json) {
    return Trainer(
      id: json.id,
      name: json.name,
      location: json.location,
      followers: json.followers,
      image: json.image,
    );
  }
}
