import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/posts/bloc/posts_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/posts/api_post_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/posts/post_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/posts/post_slide.dart';

class AllPostsScreen extends StatelessWidget {
  const AllPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsBloc(PostRepositoryImpl(
          postsDatasource: APIPostDatasource(LocalStorageService()))),
      child: const _AllPostsScreen(),
    );
  }
}

class _AllPostsScreen extends StatelessWidget {
  const _AllPostsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
          style: TextStyle(color: Colors.white, fontFamily: 'PT Sans'),
        ),
      ),
      body: const _AllPostsView(),
    );
  }
}

class _AllPostsView extends StatefulWidget {
  const _AllPostsView();

  @override
  State<_AllPostsView> createState() => _AllPostsViewState();
}

class _AllPostsViewState extends State<_AllPostsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<PostsBloc>().loadNextPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 500 >=
          _scrollController.position.maxScrollExtent) {
        context.read<PostsBloc>().loadNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state.status == PostStatus.error) {
          return const Center(
            child: Text('Something bad happend'),
          );
        }
        if (state.loadedPosts.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 27),
                  child: Text('Sort by: '),
                ),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    label: const Text('newest'))
              ],
            ),
            Expanded(
                child: GridView.builder(
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: state.loadedPosts.length,
              itemBuilder: (context, index) {
                return PostSlide(post: state.loadedPosts[index]);
              },
            )),
            if (state.status == PostStatus.loading)
              const CircularProgressIndicator()
          ],
        );
      },
    );
  }
}
