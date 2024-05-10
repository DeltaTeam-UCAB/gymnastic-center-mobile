import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/domain/repositories/comments/comments_repository.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {

  final CommentsRepository commentsRepository;

  CommentsBloc(this.commentsRepository) : super(const CommentsState()) {
    on<CommentsLoaded>(_onCommentsLoaded);
    on<CommentLiked>(_onCommentLiked);
    on<CommentDisliked>(_onCommentDisliked);

    on<ErrorOccurred>(_onErrorOccurred);
    on<CommentsCompleted>(_onCommentsCompleted);
    on<LoadingStarted>(_onLoadingStarted);
  }

  void _onLoadingStarted(LoadingStarted event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        status: CommentsStatus.error
      )
    );
  }

  void _onErrorOccurred(ErrorOccurred event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        status: CommentsStatus.error
      )
    );
  }

  void _onCommentsCompleted(CommentsCompleted event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        status: CommentsStatus.completed
      )
    );
  }

  void _onCommentsLoaded(CommentsLoaded event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        offset: state.offset + event.comments.length,
        comments: [...state.comments, ...event.comments],
        status: CommentsStatus.loaded
      )
    );
  }
  
  void _onCommentLiked(CommentLiked event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        comments: state.comments.map((comment){
          if (comment.id == event.commentId){
            return Comment(
              id: comment.id,
              username: comment.username,
              clientId: comment.clientId,
              description: comment.description,
              creationDate: comment.creationDate,
              likes: comment.likes + 1,
              dislikes: comment.dislikes,
              userLiked: !comment.userLiked);
          }
          return comment;
        }).toList(),
      )
    );
  }

  void _onCommentDisliked(CommentDisliked event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        comments: state.comments.map((comment){
          if (comment.id == event.commentId){
            return Comment(
              id: comment.id,
              username: comment.username,
              clientId: comment.clientId,
              description: comment.description,
              creationDate: comment.creationDate,
              likes: comment.likes - 1,
              dislikes: comment.dislikes,
              userLiked: !comment.userLiked);
          }
          return comment;
        }).toList(),
      )
    );
  }

Future<void> dislikeComment(String commentId, bool userliked) async{
  final commentDislikedResult = await commentsRepository.dislikeCommentById(commentId);
  if (commentDislikedResult.isSuccessful()){
    add(CommentDisliked(commentId: commentId));
    return;
  }
  add(ErrorOccurred());
}

Future<void> likeComment(String commentId, bool userliked) async{
  final commentLikedResult = await commentsRepository.likeCommentById(commentId);
  if (commentLikedResult.isSuccessful()){
    add(CommentLiked(commentId: commentId));
    return;
  }
  add(ErrorOccurred());
}

Future<void> loadNextPageByPostId(String postId) async{
  if (state.status == CommentsStatus.loading ||
        state.status == CommentsStatus.completed) return;
  add(LoadingStarted());
  final commentsResult = await commentsRepository.getCommentsByPostId(postId, limit: state.limit, offset: state.offset);
  if (commentsResult.isSuccessful()){
    final comments = commentsResult.getValue();
    if ( comments.isEmpty ){
      add(CommentsCompleted());
      return ;
    }
    add(CommentsLoaded(comments: comments));
    return ;
  }
  add(ErrorOccurred());
}
}
