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
  final String durationMinutes;
  final String durationWeeks;
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
    required this.durationWeeks,
    required this.durationMinutes,
    required this.lessons,
    required this.date,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
        id: json["id"], 
        title: json["title"], 
        description: json["description"] ?? '', 
        trainer: json["trainer"] is String
            ? TrainerResponse(id: '', name: json["trainer"])
            : TrainerResponse.fromJson(json["trainer"]),
        category: json["category"],
        image: json["image"],
        durationMinutes: json['durationMinutes'] ?? '',
        durationWeeks: json['durationWeeks'] ?? '',
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
  final int order;
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
