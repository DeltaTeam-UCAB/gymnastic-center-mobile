part of 'comments_bloc.dart';

sealed class CommentsEvent {
  const CommentsEvent();
}

class CommentsLoaded extends CommentsEvent {
  final List<Comment> comments;
  CommentsLoaded({required this.comments});
}

class CommentLiked extends CommentsEvent {
  final String commentId;
  CommentLiked({required this.commentId});
}

class CommentDisliked extends CommentsEvent {
  final String commentId;
  CommentDisliked({required this.commentId});
}

class CommentsCompleted extends CommentsEvent {}

class LoadingStarted extends CommentsEvent {}

class ErrorOccurred extends CommentsEvent {}
