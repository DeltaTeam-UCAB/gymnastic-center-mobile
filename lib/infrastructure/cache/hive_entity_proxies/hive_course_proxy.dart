import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/core/hive_entity_proxy.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/hive_trainer_proxy.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_course_proxy.g.dart';

@HiveType(typeId: 3)
class HiveCourse extends HiveEntityProxy<Course> {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final HiveTrainer trainer;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final String image;
  @HiveField(6)
  final List<String> tags;
  @HiveField(7)
  final String level;
  @HiveField(8)
  final String durationWeeks;
  @HiveField(9)
  final String durationMinutes;
  @HiveField(10)
  final DateTime released;
  @HiveField(11)
  final List<HiveLesson>? lessons;

  HiveCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.trainer,
    required this.category,
    required this.image,
    required this.tags,
    required this.level,
    required this.durationMinutes,
    required this.durationWeeks,
    required this.released,
    required this.lessons,
  });

  @override
  factory HiveCourse.fromProxiedType(Course data) {
    return HiveCourse(
        id: data.id,
        title: data.title,
        description: data.description,
        trainer: HiveTrainer.fromProxiedType(data.trainer),
        category: data.category,
        image: data.image,
        tags: data.tags,
        level: data.level,
        durationMinutes: data.durationMinutes,
        durationWeeks: data.durationWeeks,
        released: data.released,
        lessons:
            data.lessons?.map((e) => HiveLesson.fromProxiedType(e)).toList());
  }

  @override
  Course toProxiedType() {
    return Course(
        id: id,
        title: title,
        description: description,
        trainer: trainer.toProxiedType(),
        category: category,
        image: image,
        tags: tags,
        level: level,
        durationMinutes: durationMinutes,
        durationWeeks: durationWeeks,
        released: released,
        lessons: lessons?.map((e) => e.toProxiedType()).toList());
  }
}

@HiveType(typeId: 2)
class HiveLesson extends HiveEntityProxy<Lesson> {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final String video;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final int order;

  HiveLesson({
    required this.id,
    required this.title,
    required this.content,
    required this.video,
    required this.image,
    required this.order,
  });

  @override
  factory HiveLesson.fromProxiedType(Lesson data) {
    return HiveLesson(
        id: data.id,
        title: data.title,
        content: data.content,
        video: data.video,
        image: data.image,
        order: data.order);
  }

  @override
  Lesson toProxiedType() {
    return Lesson(
        id: id,
        title: title,
        content: content,
        video: video,
        image: image,
        order: order);
  }
}
