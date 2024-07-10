import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/screens/search/widgets/search_slide.dart';
import 'package:gymnastic_center/presentation/widgets/courses/courses_slideshow.dart';
import 'package:gymnastic_center/presentation/widgets/shared/no_content.dart';

class SearchTabCourses extends StatefulWidget {
  final List<Course> popularCourse;
  final List<Course> restCourse;
  final Future<void> Function() loadNextPage;
  final bool loading;

  const SearchTabCourses(
      {super.key,
      required this.popularCourse,
      required this.restCourse,
      required this.loadNextPage,
      required this.loading});

  @override
  State<SearchTabCourses> createState() => _SearchTabCoursesState();
}

class _SearchTabCoursesState extends State<SearchTabCourses> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        if (widget.restCourse.isNotEmpty) widget.loadNextPage();
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
              widget.popularCourse.isEmpty
                  ? const NoContent(
                      image: 'assets/search/not-found-2.svg',
                      text:
                          'Oops! Yoga journey took a tumble,\nno courses found.',
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
                            'Popular Courses',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CoursesSlideShow(courses: widget.popularCourse),
                        const SizedBox(height: 10),
                      ],
                    ),
              if (widget.restCourse.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'All Courses',
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
              if (widget.restCourse.isEmpty) return Container();
              if (index == widget.restCourse.length) {
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
                  child: FadeInUp(
                    child: SearchSlide(
                      routeToGo:
                          '/home/0/course/${widget.restCourse[index].id}',
                      category: widget.restCourse[index].category,
                      image: widget.restCourse[index].image,
                      title: widget.restCourse[index].title,
                      trainerName: widget.restCourse[index].trainer.name,
                    ),
                  ));
            },
            childCount: widget.restCourse.length + 1,
          ),
        ),
      ],
    );
  }
}
