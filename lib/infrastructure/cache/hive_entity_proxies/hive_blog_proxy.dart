import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/core/hive_entity_proxy.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_blog_proxy.g.dart';

@HiveType(typeId: 0)
class HiveBlog extends HiveEntityProxy<Blog> {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final DateTime released;
  @HiveField(4)
  final List<String> images;
  @HiveField(5)
  final Trainer trainer;
  @HiveField(6)
  final List<String> tags;
  @HiveField(7)
  final String category;

  HiveBlog(
      {required this.id,
      required this.title,
      required this.body,
      required this.released,
      required this.images,
      required this.trainer,
      required this.category,
      required this.tags});

  @override
  factory HiveBlog.fromProxiedType(Blog data) {
    return HiveBlog(
        id: data.id,
        title: data.title,
        body: data.body,
        released: data.released,
        images: data.images,
        trainer: data.trainer,
        category: data.category,
        tags: data.tags);
  }

  @override
  Blog toProxiedType() {
    return Blog(
        body: body,
        category: category,
        id: id,
        images: images,
        released: released,
        tags: tags,
        title: title,
        trainer: trainer);
  }
}
