part of 'comments_bloc.dart';

sealed class CommentsEvent{
  const CommentsEvent();
}

class CommentsLoaded extends CommentsEvent{
  final List<Comment> comments;
  CommentsLoaded({required this.comments});
}

class CommentLikesChanged extends CommentsEvent{
  final String commentId;
  final bool newCommentLikeState;
  CommentLikesChanged({required this.newCommentLikeState, required this.commentId});
}

class CommentDiskesChanged extends CommentsEvent{
  final String commentId;
  final bool newCommentDislikeState;
  CommentDiskesChanged({required this.newCommentDislikeState, required this.commentId});
}

class CommentRefreshed extends CommentsEvent{}

class CommentPostingStarted extends CommentsEvent{}

class CommentDeletingStarted extends CommentsEvent{}

class AllCommentsLoaded extends CommentsEvent{}

class LoadingStarted extends CommentsEvent{}

class InitialLoadingStarted extends CommentsEvent{}

class ErrorOccurred extends CommentsEvent{}