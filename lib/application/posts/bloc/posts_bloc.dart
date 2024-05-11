import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/domain/repositories/posts/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

final initialPost = Post(
    id: '',
    title: '',
    body: '',
    released: DateTime.now(),
    images: [],
    autor: '',
    tags: []);

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;

  PostsBloc(this.postsRepository)
      : super(PostsState(currentPost: initialPost)) {
    on<CurrentPostLoaded>(_onCurrentPostLoaded);
    on<PostsLoaded>(_onPostsLoaded);
    on<LoadingStarted>(_onLoadingStarted);
    on<ErrorOnPostsLoading>(_onErrorOnPostsLoading);
    on<AllPostsLoaded>(_onAllPostsLoaded);
  }

  void _onLoadingStarted(LoadingStarted event, Emitter<PostsState> emit) {
    emit(state.copyWith(status: PostStatus.loading));
  }

  void _onPostsLoaded(PostsLoaded event, Emitter<PostsState> emit) {
    emit(state.copyWith(
        loadedPosts: [...state.loadedPosts, ...event.posts],
        status: PostStatus.loaded,
        offset: event.posts.length + state.offset));
  }

  void _onCurrentPostLoaded(CurrentPostLoaded event, Emitter<PostsState> emit) {
    emit(state.copyWith(
        currentPost: event.currentPost, status: PostStatus.loaded));
  }

  void _onAllPostsLoaded(AllPostsLoaded event, Emitter<PostsState> emit) {
    emit(state.copyWith(status: PostStatus.allPostsLoaded));
  }

  void _onErrorOnPostsLoading(
      ErrorOnPostsLoading event, Emitter<PostsState> emit) {
    emit(state.copyWith(status: PostStatus.error));
  }

  Future<void> loadPostById(String postId) async {
    if (state.status == PostStatus.loading) return;
    add(LoadingStarted());
    final postResult = await postsRepository.getPostById(postId);
    if (postResult.isSuccessful()) {
      final post = postResult.getValue();
      add(CurrentPostLoaded(currentPost: post));
      return;
    }
    add(ErrorOnPostsLoading());
  }

  Future<void> loadNextPage() async {
    if (state.status == PostStatus.loading ||
        state.status == PostStatus.allPostsLoaded) return;
    add(LoadingStarted());
    final postsResult = await postsRepository.getAllPosts(
        limit: state.limit, offset: state.offset);
    if (postsResult.isSuccessful()) {
      final posts = postsResult.getValue();
      if (posts.isNotEmpty) {
        add(PostsLoaded(posts: posts));
        return;
      }
      add(AllPostsLoaded());
      return;
    }
    add(ErrorOnPostsLoading());
  }
}
