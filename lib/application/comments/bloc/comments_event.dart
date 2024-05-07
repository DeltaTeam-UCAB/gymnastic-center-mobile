part of 'comments_bloc.dart';

sealed class CommentsEvent{
  const CommentsEvent();
}

class CommentsLoaded extends CommentsEvent{
  final List<Comment> comments;
  CommentsLoaded({required this.comments});
}

class CommentsNotFound extends CommentsEvent{}