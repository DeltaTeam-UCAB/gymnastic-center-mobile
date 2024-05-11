import 'package:gymnastic_center/application/core/results.dart';
import 'package:gymnastic_center/domain/datasources/comments/comments_datasource.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/domain/repositories/comments/comments_repository.dart';

class CommentsRepositoryImpl extends CommentsRepository {
  final CommentsDatasource commentsDatasource;

  CommentsRepositoryImpl({required this.commentsDatasource});

  @override
  Future<Result<List<Comment>>> getCommentsByCourseId(String courseId,
      {int limit = 5, int offset = 0}) async {
    try {
      final comments = await commentsDatasource
          .getCommentsByCourseId(courseId, limit: limit, offset: offset);
      return Result<List<Comment>>.success(comments);
    } catch (e) {
      return Result<List<Comment>>.fail(e as Exception);
    }
  }

  @override
  Future<Result<List<Comment>>> getCommentsByPostId(String postId,
      {int limit = 5, int offset = 0}) async {
    try {
      final comments = await commentsDatasource
          .getCommentsByPostId(postId, limit: limit, offset: offset);
      return Result<List<Comment>>.success(comments);
    } catch (e) {
      return Result<List<Comment>>.fail(e as Exception);
    }
  }
  
  @override
  Future<Result<bool>> likeCommentById(String commentId) async {
    try {
      final isSuccessful = await commentsDatasource.likeCommentById(commentId);
      return Result<bool>.success(isSuccessful);
    } catch (e) {
      return Result<bool>.fail(e as Exception);
    }
  }
  
  @override
  Future<Result<bool>> deleteLikeByCommentId(String commentId) async {
    try {
      final isSuccessful = await commentsDatasource.deleteLikeByCommentId(commentId);
      return Result<bool>.success(isSuccessful);
    } catch (e) {
      return Result<bool>.fail(e as Exception);
    }
  }
}
