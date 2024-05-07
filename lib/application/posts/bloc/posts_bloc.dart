
import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/domain/repositories/posts/posts_repository.dart';


part 'posts_event.dart';
part 'posts_state.dart';

final initialPost = Post(id: '', title: '', body: '', released: DateTime.now(), images: [], autor: '', tags: []);

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  final PostsRepository postsRepository;

  PostsBloc(this.postsRepository) : super(PostsState(currentPost: initialPost)) {
    on<CurrentPostLoaded>(_currentPostLoaded);
    on<PostNotFound>(_postNotFound);

  }

  void _currentPostLoaded(CurrentPostLoaded  event, Emitter<PostsState> emit) {
    emit(
      state.copyWith(
        currentPost: event.currentPost,
        status: PostStatus.loaded
      )
    );
  }
  
  void _postNotFound(PostNotFound  event, Emitter<PostsState> emit) {
    emit(
      state.copyWith(
        status: PostStatus.error
      )
    );
  }


  Future<void> loadPostById(String postId) async{
    final postResult = await postsRepository.getPostById(postId);
    if ( postResult.isSuccessful() ){
      final post = postResult.getValue();
      add(CurrentPostLoaded(currentPost: post));
      return ;
    }
    add(PostNotFound());
  }


}
