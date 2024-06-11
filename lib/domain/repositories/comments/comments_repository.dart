import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';

abstract class CommentsRepository{
  Future<Result<List<Comment>>> getCommentsByLessonId(String lessonId, {int perPage = 5 , int page= 0});
  Future<Result<List<Comment>>> getCommentsByBlogId(String blogId, {int perPage = 5 , int page= 0});
  Future<Result<String>> createCommentByLessonId(String lessonId, String message);
  Future<Result<String>> createCommentByBlogId(String blogId, String message);
  Future<Result<bool>> toggleLikeCommentById(String commentId);
  Future<Result<bool>> toggleDislikeCommentById(String commentId);
}