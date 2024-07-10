import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/core/hive_entity_proxy.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/hive_trainer_proxy.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_trainer_details_proxy.g.dart';

@HiveType(typeId: 5)
class HiveTrainerDetails extends HiveEntityProxy<TrainerDetails> {
  @HiveField(0)
  final HiveTrainer trainer;
  @HiveField(1)
  final bool isFollowing;
  @HiveField(2)
  final int courseCount;
  @HiveField(3)
  final int blogCount;

  HiveTrainerDetails({
    required this.trainer,
    required this.isFollowing,
    this.courseCount = 0,
    this.blogCount = 0,
  });

  factory HiveTrainerDetails.fromProxiedType(TrainerDetails data) {
    return HiveTrainerDetails(
        trainer: HiveTrainer.fromProxiedType(data.trainer),
        isFollowing: data.isFollowing,
        blogCount: data.blogCount,
        courseCount: data.courseCount);
  }

  @override
  TrainerDetails toProxiedType() {
    return TrainerDetails(
        trainer: trainer.toProxiedType(),
        isFollowing: isFollowing,
        blogCount: blogCount,
        courseCount: courseCount);
  }
}
