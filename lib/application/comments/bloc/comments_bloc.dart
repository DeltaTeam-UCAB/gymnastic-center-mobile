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
    on<CommentsNotFound>(_onCommentsNotFound);
  }

  void _onCommentsNotFound(CommentsNotFound event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        status: CommentStatus.error
      )
    );
  }


  void _onCommentsLoaded(CommentsLoaded event, Emitter<CommentsState> emit){
    emit(
      state.copyWith(
        offset: state.offset + event.comments.length,
        comments: [...state.comments, ...event.comments],
        status: CommentStatus.loaded
      )
    );
  }

Future<void> loadCommentsByIdCourse(String courseId, int offset) async{
  final commentsResult = await commentsRepository.getCommentsByCourseId(courseId, offset: offset);
  if (commentsResult.isSuccessful()){
    final comments = commentsResult.getValue();
    add(CommentsLoaded(comments: comments));
    return ;
  }
  add(CommentsNotFound());
}
}
