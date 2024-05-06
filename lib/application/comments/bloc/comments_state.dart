part of 'comments_bloc.dart';

class CommentsState extends Equatable {
  final List<Comment> comments;
  final bool loading;

  const CommentsState({
    this.loading = true,
    this.comments = const []
  });
  
  CommentsState copyWith({
    List<Comment>? comments,
    bool? loading,
  })=>CommentsState(
    comments: comments ?? this.comments,
    loading: loading ?? this.loading
  );

  @override
  List<Object> get props => [];
}

final class CommentsInitial extends CommentsState {}
