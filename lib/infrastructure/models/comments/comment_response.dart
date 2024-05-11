import 'package:gymnastic_center/infrastructure/models/comments/comment_apicomment.dart';

class CommentResponse {
  final CommentApiComment comment;
  final int likes;
  final int dislikes;
  final bool userLiked;
  final String user;

  CommentResponse({
    required this.comment,
    required this.likes,
    required this.dislikes,
    required this.userLiked,
    required this.user,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
          comment: CommentApiComment.fromJson(json["comment"]),
          likes: json["likes"],
          dislikes: json["dislikes"],
          userLiked: json["userLiked"],
          user: json['user']);
}
