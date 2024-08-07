import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final Trainer trainer;
  final String category;
  final String image;
  final List<String> tags;
  final String level;
  final String durationWeeks;
  final String durationMinutes;
  final DateTime released;
  final List<Lesson> lessons;

  Course({
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
}

class Lesson {
  final String id;
  final String title;
  final String content;
  final String video;
  final int order;

  const Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.video,
    required this.order,
  });
}
