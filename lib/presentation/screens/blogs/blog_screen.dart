import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/blogs/blog-details/blog_details_bloc.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/infrastructure/datasources/blogs/api_blog_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/comments/api_comment_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blog_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/comments/comments_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/comments/comments_section.dart';
import 'package:intl/intl.dart';

class BlogScreen extends StatelessWidget {
  final String blogId;
  BlogScreen({super.key, required this.blogId});

  final LocalStorageService localStorageService = LocalStorageService();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => BlogDetailsBloc(BlogRepositoryImpl(
                  blogsDatasource: APIBlogDatasource(localStorageService)))
                ..loadBlogById(blogId)),
          BlocProvider(
              create: (_) => CommentsBloc(CommentsRepositoryImpl(
                  commentsDatasource:
                      ApiCommentDatasource(localStorageService)))),
        ],
        child: Scaffold(
            body: Stack(
          children: [
            const _BlogView(),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  title: const Text('Blog Tips & Topic Details',
                      style: TextStyle(color: Colors.white)),
                  elevation: 0,
                )),
          ],
        )));
  }
}

class _BlogView extends StatelessWidget {
  const _BlogView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogDetailsBloc, BlogDetailsState>(
      builder: (context, state) {
        if (state.blog.id.isEmpty ||
            state.status == BlogDetailsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == BlogDetailsStatus.error) {
          return const Center(
            child: Text('Blog Not found'),
          );
        }
        return SingleChildScrollView(
          child: _BlogDetailsView(state.blog),
        );
      },
    );
  }
}

class _BlogDetailsView extends StatelessWidget {
  final Blog blog;
  final titleFontSize = 32.0;
  final dateFormat = DateFormat('dd-MM-yyyy');
  _BlogDetailsView(this.blog);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ImagesCarrousel(blog.images),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Text(blog.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: titleFontSize)),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => context.push('/home/0/trainer/${blog.trainer.id}'),
                    child: Text(
                      'By: ${blog.trainer.name}',
                      style: TextStyle(
                          color: Colors.deepPurple.shade200,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 16,
                    color: textTheme.labelLarge!.color,
                  ),
                  Text(dateFormat.format(blog.released),
                      style: textTheme.labelLarge),
                ]),
              ),
              Divider(
                color: colors.primary,
              ),
              //COntent
              Text(blog.body, style: textTheme.bodyLarge),
              Divider(
                color: colors.primary,
              ),
              Text('Tags: ${blog.tags.join(', ')}',
                  style: textTheme.bodyMedium),
              Divider(
                color: colors.primary,
              ),
              const SizedBox(
                height: 15,
              ),
              Text('Comments', style: textTheme.titleLarge),
              SizedBox(
                height: 400,
                child: CommentsSection(blogId: blog.id,),
              )
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
