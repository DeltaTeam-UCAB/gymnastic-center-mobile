import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/comments/comments_datasource.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/domain/repositories/comments/comments_repository.dart';

class CommentsRepositoryImpl extends CommentsRepository {
  final CommentsDatasource commentsDatasource;

  CommentsRepositoryImpl({required this.commentsDatasource});

  @override
  Future<Result<List<Comment>>> getCommentsById(String targetId, String targetType, {int perPage = 5, int page = 0}) async {
    try {
      final comments = await commentsDatasource
          .getCommentsById(targetId, targetType, perPage: perPage, page: page);
      return Result<List<Comment>>.success(comments);
    } catch (e) {
      return Result<List<Comment>>.fail(e as Exception);
    }
  }
  
  @override
  Future<Result<bool>> toggleDislikeCommentById(String commentId) async {
    try {
      final dislike = await commentsDatasource.toggleDislikeCommentById(commentId);
      return Result<bool>.success(dislike);
    } catch (e) {
      return Result<bool>.fail(e as Exception);
    }
  }
  
  @override
  Future<Result<bool>> toggleLikeCommentById(String commentId) async {
    try {
      final dislike = await commentsDatasource.toggleLikeCommentById(commentId);
      return Result<bool>.success(dislike);
    } catch (e) {
      return Result<bool>.fail(e as Exception);
    }
  }
  
  @override
  Future<Result<bool>> createComment(String targetId, String targetType, String message) async {
    try {
      await commentsDatasource.createComment(targetId, targetType, message);
      return Result.success(true);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
  
  @override
  Future<Result<bool>> deleteComment(String commentId) async {
    try {
      await commentsDatasource.deleteComment(commentId);
      return Result.success(true);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}
