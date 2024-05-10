import 'dart:core';


class CommentApiComment {
    final String id;
    final String clientId;
    final String description;
    final DateTime creationDate;

    CommentApiComment({
        required this.id,
        required this.clientId,
        required this.description,
        required this.creationDate,
    });

    factory CommentApiComment.fromJson(Map<String, dynamic> json) => CommentApiComment(
        id: json["id"],
        clientId: json["clientId"],
        description: json["description"],
        creationDate: DateTime.parse(json["creationDate"]),
    );
} 