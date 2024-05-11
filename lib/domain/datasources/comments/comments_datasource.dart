import 'package:gymnastic_center/domain/entities/comments/comment.dart';

abstract class CommentsDatasource {
  Future<List<Comment>> getCommentsByCourseId(String courseId,
      {int limit = 5, int offset = 0});
  Future<List<Comment>> getCommentsByPostId(String postId,
      {int limit = 5, int offset = 0});
  Future<bool> likeCommentById(String commentId);
  Future<bool> deleteLikeByCommentId(String commentId);
}
