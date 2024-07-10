import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/domain/repositories/comments/comments_repository.dart';

class MockCommentsRepository extends CommentsRepository {

  final List<Comment> mockComments;
  final bool shouldFail;
  MockCommentsRepository(this.mockComments, [this.shouldFail = false]);

  @override
  Future<Result<String>> createComment(String targetId, String targetType, String message) {
    if ( shouldFail ) {
      return Future.value(Result.fail(Exception()));
    }
    return Future.value(Result.success('1'));
  }

  @override
  Future<Result<bool>> deleteComment(String commentId) {
    if ( shouldFail ) {
      return Future.value(Result.fail(Exception()));
    }
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<List<Comment>>> getCommentsById(String targetId, String targetType, {int perPage = 5, int page = 0}) {
    
    if ( shouldFail ) {
      return Future.value(Result.fail(Exception()));
    }
    if ( mockComments.isEmpty ) {
      return Future.value(Result.success([]));
    }
    return Future.value(Result.success(mockComments.sublist((page - 1) * perPage, page * perPage)));
  }

  @override
  Future<Result<bool>> toggleDislikeCommentById(String commentId) {
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<bool>> toggleLikeCommentById(String commentId) {
    return Future.value(Result.success(true));
  }
}