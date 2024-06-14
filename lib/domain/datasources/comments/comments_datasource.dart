import 'package:gymnastic_center/domain/entities/comments/comment.dart';

abstract class CommentsDatasource {
  Future<List<Comment>> getCommentsByLessonId(String lessonId, {int perPage = 5 , int page= 0});
  Future<List<Comment>> getCommentsByBlogId(String blogId, {int perPage = 5 , int page= 0});
  Future<String> createCommentsByLessonId(String lessonId, String message);
  Future<String> createCommentsByBlogId(String blogId, String message);
  Future<bool> toggleLikeCommentById(String commentId);
  Future<bool> toggleDislikeCommentById(String commentId);
}
