import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/comments/api_comment_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/comments/comments_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/commnets/comments_list.dart';
import 'package:intl/intl.dart';
import 'package:gymnastic_center/application/posts/bloc/posts_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/posts/api_post_datasource.dart';
import 'package:gymnastic_center/infrastructure/repositories/posts/post_repository_impl.dart';

class PostScreen extends StatelessWidget {
  final String postId;
  PostScreen({super.key, required this.postId});

  final LocalStorageService localStorageService = LocalStorageService();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PostsBloc(PostRepositoryImpl(
              postsDatasource: APIPostDatasource(localStorageService)))
            ..loadPostById(postId)),
        BlocProvider(
          create: (_) => CommentsBloc(
                CommentsRepositoryImpl(
                  commentsDatasource: ApiCommentDatasource(localStorageService)
              )
            )..loadNextPageByPostId(postId)
        ),
      ],
      child: Scaffold(
        body: Stack(
        children: [
          const _PostView(),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                title: const Text('Post Tips & Topic Details',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                elevation: 0,
              )),
        ],
      ))
    );
  }
}

class _PostView extends StatelessWidget {
  const _PostView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state.currentPost.id.isEmpty || state.status == PostStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == PostStatus.error) {
          return const Center(
            child: Text('Post Not found'),
          );
        }
        return SingleChildScrollView(
          child: _PostDetailsView(),
        );
      },
    );
  }
}

class _PostDetailsView extends StatelessWidget {
  final titleFontSize = 32.0;
  final dateFormat = DateFormat('dd-MM-yyyy');
  _PostDetailsView();

  @override
  Widget build(BuildContext context) {
    final post = context.read<PostsBloc>().state.currentPost;
    final comments = context.watch<CommentsBloc>().state.comments;

    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ImagesCarrousel(post.images),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(post.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: titleFontSize)),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  Text('Por ${post.autor}', style: textTheme.labelLarge),
                  const Spacer(),
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 16,
                    color: textTheme.labelLarge!.color,
                  ),
                  Text(dateFormat.format(post.released),
                      style: textTheme.labelLarge),
                ]),
              ),
              Divider(
                color: colors.primary,
              ),
              //COntent
              Text(post.body, style: textTheme.bodyLarge),
              Divider(
                color: colors.primary,
              ),
              Text('Tags: ${post.tags.join(', ')}',
                  style: textTheme.bodyMedium),
              Divider(
                color: colors.primary,
              ),
              const SizedBox(
                height: 15,
              ),
              Text('Comentarios',
                  style: textTheme.titleLarge),
              CommentsList(comments),
            ],
          ),
        ),
      ],
    );
  }
}

class _ImagesCarrousel extends StatelessWidget {
  final height = 300.0;
  final List<String> urlImages;

  const _ImagesCarrousel(this.urlImages);

  @override
  Widget build(BuildContext context) {
    if (urlImages.length == 1) {
      return SizedBox(
        height: height,
        width: double.infinity,
        child: Image.network(
          urlImages[0],
          fit: BoxFit.fill,
        ),
      );
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            urlImages[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: urlImages.length,
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
      ),
    );
  }
}
