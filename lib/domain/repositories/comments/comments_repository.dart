import 'package:gymnastic_center/application/core/results.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';

abstract class CommentsRepository{
  Future<Result<List<Comment>>> getCommentsByCourseId(String courseId, {int limit, int offset});
  Future<Result<List<Comment>>> getCommentsByPostId(String postId, {int limit, int offset});
  Future<Result<bool>> likeCommentById(String commentId);
  Future<Result<bool>> dislikeCommentById(String commentId);


}