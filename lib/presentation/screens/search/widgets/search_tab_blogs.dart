import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/presentation/screens/search/widgets/search_slide.dart';
import 'package:gymnastic_center/presentation/widgets/blogs/blogs_slideshow.dart';
import 'package:gymnastic_center/presentation/widgets/shared/no_content.dart';

class SearchTabBlogs extends StatefulWidget {
  final List<Blog> popularBlogs;
  final List<Blog> restBlogs;
  final Future<void> Function() loadNextPage;
  final bool loading;

  const SearchTabBlogs(
      {super.key,
      required this.popularBlogs,
      required this.restBlogs,
      required this.loadNextPage,
      required this.loading});

  @override
  State<SearchTabBlogs> createState() => _SearchTabBlogsState();
}

class _SearchTabBlogsState extends State<SearchTabBlogs> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        if (widget.restBlogs.isNotEmpty) widget.loadNextPage();
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
    final bool isDark = context.read<ThemesBloc>().isDarkMode;
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.popularBlogs.isEmpty
                  ? const NoContent(
                      image: 'assets/search/not-found.svg',
                      text: 'Oops! Runner stumbled, \nno blogs found.',
                      heighFactor: 1.2,
                      width: 300,
                      height: 300,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16, left: 16),
                          child: Text(
                            'Popular Blogs',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlogsSlideShow(blogs: widget.popularBlogs),
                        const SizedBox(height: 10),
                      ],
                    ),
              if (widget.restBlogs.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'All Blogs',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (widget.restBlogs.isEmpty) Container();
              if (index == widget.restBlogs.length) {
                return widget.loading
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container();
              }
              return Padding(
                  padding: const EdgeInsets.all(12),
                  child: SearchSlide(
                    routeToGo: '/blog/${widget.restBlogs[index].id}',
                    category: widget.restBlogs[index].category,
                    image: widget.restBlogs[index].images[0],
                    title: widget.restBlogs[index].title,
                    trainerName: widget.restBlogs[index].trainer.name,
                  ));
            },
            childCount: widget.restBlogs.length + 1,
          ),
        ),
      ],
    );
  }
}
