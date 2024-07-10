import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/core/hive_entity_proxy.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_trainer_proxy.g.dart';

@HiveType(typeId: 4)
class HiveTrainer extends HiveEntityProxy<Trainer> {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String location;
  @HiveField(3)
  final int followers;
  @HiveField(4)
  final String image;

  HiveTrainer({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    this.followers = 0,
  });

  factory HiveTrainer.fromProxiedType(Trainer data) {
    return HiveTrainer(
        id: data.id,
        name: data.name,
        location: data.location,
        image: data.image,
        followers: data.followers);
  }

  @override
  Trainer toProxiedType() {
    return Trainer(
        id: id,
        name: name,
        location: location,
        image: image,
        followers: followers);
  }
}
