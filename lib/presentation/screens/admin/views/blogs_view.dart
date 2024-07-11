import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/application/blogs/delete-blog/delete_blog_bloc.dart';
import 'package:gymnastic_center/domain/datasources/blogs/blogs_datasource.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/presentation/screens/admin/widgets/slide_admin.dart';

class BlogsAdminView extends StatefulWidget {
  const BlogsAdminView({super.key});

  @override
  State<BlogsAdminView> createState() => _BlogsAdminViewState();
}

class _BlogsAdminViewState extends State<BlogsAdminView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (context.read<BlogsBloc>().state.loadedBlogs.isNotEmpty) {
      context.read<BlogsBloc>().refreshBlogs();
    }

    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<BlogsBloc>().loadNextPage(filter: BlogFilter.recent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final void Function() refresh =  context.watch<BlogsBloc>().refreshBlogs;

    return BlocListener<DeleteBlogBloc, DeleteBlogState>(
      listener: (context, state) {
        if (state.status == DeleteBlogStatus.deleted) {
          refresh();
        }
      },
      child: BlocBuilder<BlogsBloc, BlogsState>(
        builder: (context, state) {
          if (state.status == BlogStatus.loading ) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == BlogStatus.error) {
            return const Center(
              child: Text('Error'),
            );
          }

          if (state.loadedBlogs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElasticIn(child: SvgPicture.asset('assets/search/not-found.svg', width: 450,)),
                  const SizedBox(height: 10),
                  const Text('No blogs found. Ups!', style: TextStyle(fontSize: 20)),
                ],
              )
            );
          }

          return CustomGridView(
              scrollController: _scrollController, blogs: state.loadedBlogs);
        },
      ),
    );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required ScrollController scrollController,
    required this.blogs,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Blog> blogs;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15),
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        final blog = blogs[index];
        return SlideAdmin(
          id: blog.id,
          image: blog.images.first,
          onPressed: context.read<DeleteBlogBloc>().deleteBlog,
          title: blog.title,
          trainer: blog.trainer.name,
          type: 'Blog',
        );
      },
    );
  }
}
