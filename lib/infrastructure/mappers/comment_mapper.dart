import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/infrastructure/models/comments/comment_apiresponse.dart';

class CommentMapper{

  static List<Comment> apiCommentsEntity(List<CommentApiResponse> commentsApiResponse){
    return commentsApiResponse.map((commentApiResponse) {
      return Comment(
        id: commentApiResponse.id,
        username: commentApiResponse.user,
        body: commentApiResponse.body,
        creationDate: commentApiResponse.date,
        likes: commentApiResponse.countLikes,
        dislikes: commentApiResponse.countDislikes,
        userLiked: commentApiResponse.userLiked,
        userDisliked: commentApiResponse.userDisliked
      );
    }).toList();
  }


}