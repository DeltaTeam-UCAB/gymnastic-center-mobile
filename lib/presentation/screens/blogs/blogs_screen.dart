import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/blogs/api_blog_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blog_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/blogs/blog_slide.dart';

class AllBlogsScreen extends StatelessWidget {
  final String? selectedCategoryId;
  final String? selectedTrainerId;
  const AllBlogsScreen(
      {super.key, this.selectedCategoryId, this.selectedTrainerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlogsBloc(BlogRepositoryImpl(
          blogsDatasource: APIBlogDatasource(LocalStorageService()))),
      child: _AllBlogsScreen(
        selectedCategoryId: selectedCategoryId,
        selectedTrainerId: selectedTrainerId,
      ),
    );
  }
}

class _AllBlogsScreen extends StatefulWidget {
  final String? selectedCategoryId;
  final String? selectedTrainerId;
  const _AllBlogsScreen(
      {required this.selectedCategoryId, required this.selectedTrainerId});

  @override
  State<_AllBlogsScreen> createState() => _AllBlogsScreenState();
}

class _AllBlogsScreenState extends State<_AllBlogsScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<BlogsBloc>().loadNextPage(
        categoryId: widget.selectedCategoryId,
        trainerId: widget.selectedTrainerId);

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
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Blogs',
            style: TextStyle(color: Colors.white, fontFamily: 'PT Sans'),
          ),
        ),
        body: BlocBuilder<BlogsBloc, BlogsState>(
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
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                    child: GridView.builder(
                  padding: const EdgeInsets.all(4),
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
        ));
  }
}
