part of 'comments_bloc.dart';

enum CommentsStatus{
  error, 
  initialLoading,
  loading,
  loaded,
  allCommentsLoaded
}

class CommentsState extends Equatable {
  final List<Comment> comments;
  final CommentsStatus status;
  final bool isPosting;
  final int page;

  const CommentsState({
    this.status = CommentsStatus.initialLoading,
    this.comments = const [],
    this.page = 0,
    this.isPosting = false
  });
  
  CommentsState copyWith({
    List<Comment>? comments,
    CommentsStatus? status,
    int? page,
    bool? isPosting,
  })=>CommentsState(
    comments: comments ?? this.comments,
    status: status ?? this.status,
    page: page ?? this.page,
    isPosting: isPosting ?? this.isPosting,
  );

  @override
  List<Object> get props => [comments, status, isPosting];
}

