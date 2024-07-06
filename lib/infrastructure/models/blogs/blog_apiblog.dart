import 'dart:core';

import 'package:gymnastic_center/infrastructure/models/trainer/trainer_response.dart';

class BlogAPIBlog {
  final String id;
  final String title;
  final String body;
  final List<String> tags;
  final TrainerResponse trainer;
  final DateTime date;
  final List<String> images;
  final String category;

  BlogAPIBlog({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.trainer,
    required this.date,
    required this.images,
    required this.category,
  });

  factory BlogAPIBlog.fromJson(Map<String, dynamic> json) => BlogAPIBlog(
        id: json["id"],
        title: json["title"],
        body: json["description"] ?? '',
        tags: json["tags"] != null
            ? List<String>.from(json["tags"].map((x) => x.toString()))
            : [],
        trainer: json["trainer"] is String
            ? TrainerResponse(id: '', name: json["trainer"])
            : TrainerResponse.fromJson(json["trainer"]),
        category: json["category"],
        date: DateTime.parse(json["date"]),
        images: json["images"] == null
            ? [json["image"]]
            : List<String>.from(json["images"].map((x) => x.toString()))
      );
}
