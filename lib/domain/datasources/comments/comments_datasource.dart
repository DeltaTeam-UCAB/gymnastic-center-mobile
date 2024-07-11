import 'package:gymnastic_center/domain/entities/comments/comment.dart';

abstract class CommentsDatasource {
  Future<List<Comment>> getCommentsById(String targetId, String targetType, {int perPage = 5 , int page= 0});
  Future<void> createComment(String targetId, String targetType, String message);
  Future<void> deleteComment(String commentId);
  Future<bool> toggleLikeCommentById(String commentId);
  Future<bool> toggleDislikeCommentById(String commentId);
}
