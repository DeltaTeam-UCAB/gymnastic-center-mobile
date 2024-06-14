import 'package:gymnastic_center/infrastructure/models/trainer/trainer_response.dart';

class CourseResponse {
  final List<String> tags;
  final String level;
  final String id;
  final String title;
  final String description;
  final TrainerResponse trainer;
  final String category;
  final String image;
  final List<LessonResponse> lessons;
  final DateTime date;

  CourseResponse({
    required this.tags,
    required this.level,
    required this.id,
    required this.title,
    required this.description,
    required this.trainer,
    required this.category,
    required this.image,
    required this.lessons,
    required this.date,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
        id: json["id"], // Viene
        title: json["title"], // Viene
        description: json["description"], // Viene
        trainer: json["trainer"] is String // Viene pero diferente segun el caso
            ? TrainerResponse(id: '', name: json["trainer"])
            : TrainerResponse.fromJson(json["trainer"]),
        category: json["category"], // Viene
        image: json["image"], // Viene

        tags: json["tags"] != null
            ? List<String>.from(json["tags"].map((x) => x))
            : [],
        date: DateTime.parse(json["date"]),
        lessons: json["lessons"] != null
            ? List<LessonResponse>.from(
                json["lessons"].map((x) => LessonResponse.fromJson(x)))
            : [],
        level: json["level"] ?? '',
      );
}

class LessonResponse {
  final String id;
  final String title;
  final String content;
  final String video;
  final String order;
  final String image;

  LessonResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.video,
    required this.order,
    required this.image,
  });

  factory LessonResponse.fromJson(Map<String, dynamic> json) => LessonResponse(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        video: json["video"] ?? '',
        order: json["order"],
        image: json["image"] ?? '',
      );
}
