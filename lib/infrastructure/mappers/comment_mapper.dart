import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/infrastructure/models/comments/comment_response.dart';

class CommentMapper{

  static List<Comment> apiCommentsEntity(List<CommentResponse> commentsResponse){
    return commentsResponse.map((commentResponse) {
      return Comment(
        id: commentResponse.comment.id,
        username: commentResponse.user,
        clientId: commentResponse.comment.clientId,
        description: commentResponse.comment.description,
        creationDate: commentResponse.comment.creationDate,
        likes: commentResponse.likes,
        dislikes: commentResponse.dislikes,
        userLiked: commentResponse.userLiked
      );
    }).toList();
  }


}