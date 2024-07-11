import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/comments/comment.dart';
import 'package:gymnastic_center/domain/repositories/comments/comments_repository.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends SafeBloc<CommentsEvent, CommentsState> {
  final CommentsRepository commentsRepository;

  CommentsBloc(this.commentsRepository) : super(const CommentsState()) {
    on<InitialLoadingStarted>(_onInitialLoadingStarted);
    on<CommentsLoaded>(_onCommentsLoaded);
    on<AllCommentsLoaded>(_onAllCommentsLoaded);
    on<CommentLikesChanged>(_onCommentLikesChanged);
    on<CommentDiskesChanged>(_onCommentDiskesChanged);
    on<LoadingStarted>(_onLoadingStarted);
    on<CommentRefreshed>(_onCommentRefreshed);
    on<CommentPostingStarted>(_onCommentPostingStarted);
    on<CommentDeletingStarted>(_onCommentDeletingStarted);
    on<ErrorOccurred>(_onErrorOccurred);
  }


  void _onCommentRefreshed(CommentRefreshed event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        page: 0,
        comments: [],
        isPosting: false,
        status: CommentsStatus.initialLoading,
      )
    );
  }

  void _onCommentPostingStarted(CommentPostingStarted event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        isPosting: true
      )
    );
  }

  void _onLoadingStarted(LoadingStarted event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        status: CommentsStatus.loading
      )
    );
  }

  void _onInitialLoadingStarted(InitialLoadingStarted event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        status: CommentsStatus.initialLoading,
        page: 0,
        comments: [],
        isPosting: false
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

  void _onAllCommentsLoaded(AllCommentsLoaded event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        status: CommentsStatus.allCommentsLoaded
      )
    );
  }

  void _onCommentsLoaded(CommentsLoaded event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        page: state.page + 1,
        comments: [...state.comments, ...event.comments],
        status: CommentsStatus.loaded
      )
    );
  }
  
  void _onCommentDeletingStarted(CommentDeletingStarted event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        isPosting: true
      )
    );
  }
  
  void _onCommentLikesChanged(CommentLikesChanged event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        comments: state.comments.map((comment){
          if (comment.id == event.commentId){
            
            late int newLikes; 
            late int newDislikes;
            if ( event.newCommentLikeState ){
              newLikes = comment.likes + 1;
              (comment.userDisliked) ? newDislikes = comment.dislikes - 1 : newDislikes = comment.dislikes;
            } else {
              newLikes = comment.likes - 1;
              newDislikes = comment.dislikes;
            }
            return Comment(
              id: comment.id,
              userId: comment.userId,
              username: comment.username,
              body: comment.body,
              creationDate: comment.creationDate,
              likes: newLikes,
              dislikes: newDislikes,
              userLiked: event.newCommentLikeState,
              userDisliked: false
            );
          }
          return comment;
        }).toList(),
      )
    );
  }

  void _onCommentDiskesChanged(CommentDiskesChanged event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        comments: state.comments.map((comment){
          if (comment.id == event.commentId){
            late int newLikes; 
            late int newDislikes;
            if ( event.newCommentDislikeState ){
              newDislikes = comment.dislikes + 1;
              (comment.userLiked) ? newLikes = comment.likes - 1 : newLikes = comment.likes;
            } else {
              newLikes = comment.likes;
              newDislikes = comment.dislikes - 1;
            }
            return Comment(
              id: comment.id,
              userId: comment.userId,
              username: comment.username,
              body: comment.body,
              creationDate: comment.creationDate,
              likes: newLikes,
              dislikes: newDislikes,
              userLiked: false,
              userDisliked: event.newCommentDislikeState
            );
          }
          return comment;
        }).toList(),
      )
    );
  }

  Future<void> toggleLike(String commentId, bool commentLikeState) async{
    final commentLikedResult = await commentsRepository.toggleLikeCommentById(commentId);
    if (commentLikedResult.isSuccessful()){
      add(CommentLikesChanged(commentId: commentId, newCommentLikeState: !commentLikeState));
      return;
    }
    add(ErrorOccurred());
  }

  Future<void> toggleDislike(String commentId, bool commentDislikeState) async{
    final commentDislikedResult = await commentsRepository.toggleDislikeCommentById(commentId);
    if (commentDislikedResult.isSuccessful()){
      add(CommentDiskesChanged(commentId: commentId, newCommentDislikeState: !commentDislikeState));
      return;
    }
    add(ErrorOccurred());
  }

  Future<void> loadNextPageById(String targetId, String targetType, {int perPage = 5}) async{
    if (state.status == CommentsStatus.loading ||
          state.status == CommentsStatus.allCommentsLoaded) return;
    add(LoadingStarted());
    final commentsResult = await commentsRepository.getCommentsById(targetId, targetType, page: state.page + 1, perPage: perPage);
    if (commentsResult.isSuccessful()){
      final comments = commentsResult.getValue();
      if ( comments.isEmpty ){
        add(AllCommentsLoaded());
        return ;
      }
      add(CommentsLoaded(comments: comments));
      return ;
    }
    add(ErrorOccurred());
  }
  
  Future<void> startInitialLoad(String targetId, String targetType, {int perPage = 5}) async{
    add(InitialLoadingStarted());
    final commentsResult = await commentsRepository.getCommentsById(targetId, targetType, page: 1, perPage: perPage);
    if (commentsResult.isSuccessful()){
      final comments = commentsResult.getValue();
      if ( comments.isEmpty ){
        add(AllCommentsLoaded());
        return ;
      }
      add(CommentsLoaded(comments: comments));
      return ;
    }
    add(ErrorOccurred());
  }

  Future<void> createComment(String targetId, String targetType, String message) async{
    if ( message.trim().isEmpty ) return ;
    add(CommentPostingStarted());
    final createCommentResult = await commentsRepository.createComment(targetId, targetType, message);
    if (createCommentResult.isSuccessful()){
      add(CommentRefreshed());
      return ;
    }
    add(ErrorOccurred());
  }

  Future<void> deleteComment(String commentId) async {
    add(CommentDeletingStarted());
    final commentResult = await commentsRepository.deleteComment(commentId);
    if (commentResult.isSuccessful()){
      add(CommentRefreshed());
      return ;
    }
    add(ErrorOccurred());
  }

}
