import 'package:gymnastic_center/infrastructure/models/comments/comment_apicomment.dart';

class CommentResponse {
    final CommentApiComment comment;
    final int likes;
    final int dislikes;
    final bool userLiked;

    CommentResponse({
        required this.comment,
        required this.likes,
        required this.dislikes,
        required this.userLiked,
    });

    factory CommentResponse.fromJson(Map<String, dynamic> json) => CommentResponse(
        comment: CommentApiComment.fromJson(json["comment"]),
        likes: json["likes"],
        dislikes: json["dislikes"],
        userLiked: json["userLiked"],
    );
}
