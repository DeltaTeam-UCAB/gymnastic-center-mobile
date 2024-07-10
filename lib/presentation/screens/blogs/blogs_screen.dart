import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/widgets/blogs/blog_slide.dart';
import 'package:gymnastic_center/presentation/widgets/shared/no_content.dart';

class AllBlogsScreen extends StatelessWidget {
  final String? selectedCategoryId;
  final String? selectedTrainerId;
  const AllBlogsScreen(
      {super.key, this.selectedCategoryId, this.selectedTrainerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BlogsBloc>(),
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
            if (state.status == BlogStatus.loading && state.loadedBlogs.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == BlogStatus.error) {
              return const Center(
                child: Text('Something bad happend'),
              );
            }
            return Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                state.loadedBlogs.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                        padding: const EdgeInsets.all(4),
                        controller: _scrollController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: state.loadedBlogs.length,
                        itemBuilder: (context, index) {
                          return BlogSlide(blog: state.loadedBlogs[index]);
                        },
                      ))
                    : const NoContent(image: 'assets/stretch.svg', text: 'Ups!! No content yet...',)
              ],
            );
          },
        ));
  }
}
