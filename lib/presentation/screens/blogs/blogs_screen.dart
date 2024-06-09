import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/blogs/api_blog_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blog_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/blogs/blog_slide.dart';

class AllBlogsScreen extends StatelessWidget {
  const AllBlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlogsBloc(BlogRepositoryImpl(
          blogsDatasource: APIBlogDatasource(LocalStorageService()))),
      child: const _AllBlogsScreen(),
    );
  }
}

class _AllBlogsScreen extends StatelessWidget {
  const _AllBlogsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blogs',
          style: TextStyle(color: Colors.white, fontFamily: 'PT Sans'),
        ),
      ),
      body: const _AllBlogsView(),
    );
  }
}

class _AllBlogsView extends StatefulWidget {
  const _AllBlogsView();

  @override
  State<_AllBlogsView> createState() => _AllBlogsViewState();
}

class _AllBlogsViewState extends State<_AllBlogsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<BlogsBloc>().loadNextPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 500 >=
          _scrollController.position.maxScrollExtent) {
        context.read<BlogsBloc>().loadNextPage();
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
    return BlocBuilder<BlogsBloc, BlogsState>(
      builder: (context, state) {
        if (state.status == BlogStatus.error) {
          return const Center(
            child: Text('Something bad happend'),
          );
        }
        if (state.loadedBlogs.isEmpty) {
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
              itemCount: state.loadedBlogs.length,
              itemBuilder: (context, index) {
                return BlogSlide(blog: state.loadedBlogs[index]);
              },
            )),
            if (state.status == BlogStatus.loading)
              const CircularProgressIndicator()
          ],
        );
      },
    );
  }
}
