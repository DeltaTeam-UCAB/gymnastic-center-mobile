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
    on<CommentLikesChanged>(_onCommentLikesChanged);
    on<CommentDiskesChanged>(_onCommentDiskesChanged);
    on<ErrorOccurred>(_onErrorOccurred);
    on<AllCommentsLoaded>(_onAllCommentsLoaded);
    on<CommentsReset>(_onCommentsReset);
    on<LoadingStarted>(_onLoadingStarted);
    on<CommentPosted>(_onCommentPosted);
    on<CommentPostingStarted>(_onCommentPostingStarted);
  }


  void _onCommentPosted(CommentPosted event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        page: 0,
        comments: [],
        isPosting: false
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

  void _onCommentsReset(CommentsReset event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        page: -1,
        comments: [],
        status: CommentsStatus.loaded,
        isPosting: false
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
              if (comment.userDisliked) { 
                newDislikes = comment.dislikes - 1;
              }else{
                newDislikes = comment.dislikes;
              }
            } else {
              newLikes = comment.likes - 1;
              newDislikes = comment.dislikes;
            }

            return Comment(
              id: comment.id,
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
              if (comment.userLiked) { 
                newLikes = comment.likes - 1;
              }else{
                newLikes = comment.likes;
              }
            } else {
              newLikes = comment.likes;
              newDislikes = comment.dislikes - 1;
            }
            return Comment(
              id: comment.id,
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

  Future<void> toggleLike(String commentId) async{
    final commentLikedResult = await commentsRepository.toggleLikeCommentById(commentId);
    if (commentLikedResult.isSuccessful()){
      add(CommentLikesChanged(commentId: commentId, newCommentLikeState: commentLikedResult.getValue()));
      return;
    }
    add(ErrorOccurred());
  }

  Future<void> toggleDislike(String commentId) async{
    final commentDislikedResult = await commentsRepository.toggleDislikeCommentById(commentId);
    if (commentDislikedResult.isSuccessful()){
      add(CommentDiskesChanged(commentId: commentId, newCommentDislikeState: commentDislikedResult.getValue()));
      return;
    }
    add(ErrorOccurred());
  }

  Future<void> loadNextPageByBlogId(String blogId) async{
    if (state.status == CommentsStatus.loading ||
          state.status == CommentsStatus.allCommentsLoaded) return;
    add(LoadingStarted());
    final commentsResult = await commentsRepository.getCommentsByBlogId(blogId, page: state.page + 1);
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

  Future<void> loadNextPageByLessonId(String lessonId) async{
    if (state.status == CommentsStatus.loading ||
          state.status == CommentsStatus.allCommentsLoaded) return;
    add(LoadingStarted());
    final commentsResult = await commentsRepository.getCommentsByLessonId(lessonId, page: state.page + 1);
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

  Future<void> createCommentByLessonId(String lessonId, String message) async{
    if ( message.trim().isEmpty ) return ;
    add(CommentPostingStarted());
    final createCommentResult = await commentsRepository.createCommentByLessonId(lessonId, message);
    if (createCommentResult.isSuccessful()){
      add(CommentPosted());
      return ;
    }
    add(ErrorOccurred());
  }

  Future<void> createCommentByBlogId(String blogId, String message) async{
    if ( message.trim().isEmpty ) return ;
    add(CommentPostingStarted());
    final createCommentResult = await commentsRepository.createCommentByBlogId(blogId, message);
    if (createCommentResult.isSuccessful()){
      add(CommentPosted());
      return ;
    }
    add(ErrorOccurred());
  }

  void reset(){
    add(CommentsReset());
  }

}
