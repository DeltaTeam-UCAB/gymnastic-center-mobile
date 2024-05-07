import 'dart:core';

class PostAPIPost {
  final String id;
  final String title;
  final String body;
  final List<String> tags;
  final String autor;
  final DateTime date;
  final List<APIImage> images;

  PostAPIPost({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.autor,
    required this.date,
    required this.images,
  });

  factory PostAPIPost.fromJson(Map<String, dynamic> json) => PostAPIPost(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        tags: List<String>.from(json["tags"].map((x) => x.toString())),
        autor: json["autor"],
        date: DateTime.parse(json["date"]),
        images: List<APIImage>.from(
            json["images"].map((x) => APIImage.fromJson(x))),
      );
}

class APIImage {
  final String id;
  final String src;

  APIImage({
    required this.id,
    required this.src,
  });
  factory APIImage.fromJson(Map<String, dynamic> json) =>
      APIImage(id: json['id'], src: json['src']);
}
