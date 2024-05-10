part of 'comments_bloc.dart';

enum CommentsStatus{
  error, 
  loading,
  loaded,
  completed
}

class CommentsState extends Equatable {
  final List<Comment> comments;
  final CommentsStatus status;
  final int limit;
  final int offset;

  const CommentsState({
    this.status = CommentsStatus.loaded,
    this.comments = const [],
    this.limit = 5,
    this.offset = 0
  });
  
  CommentsState copyWith({
    List<Comment>? comments,
    CommentsStatus? status,
    int? limit,
    int? offset,
  })=>CommentsState(
    comments: comments ?? this.comments,
    status: status ?? this.status,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset
  );

  @override
  List<Object> get props => [comments, status];
}

