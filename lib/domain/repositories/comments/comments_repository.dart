import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';

abstract class CommentsRepository{
  Future<Result<List<Comment>>> getCommentsById(String targetId, String targetType, {int perPage = 5 , int page= 0});
  Future<Result<String>> createComment(String targetId, String targetType, String message);
  Future<Result<bool>> deleteComment(String commentId);
  Future<Result<bool>> toggleLikeCommentById(String commentId);
  Future<Result<bool>> toggleDislikeCommentById(String commentId);
}