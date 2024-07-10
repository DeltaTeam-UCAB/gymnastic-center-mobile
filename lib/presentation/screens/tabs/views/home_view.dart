import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/application/categories/bloc/categories_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/application/suscriptions/trending-progress/trending_progress_bloc.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/screens/suscriptions/treding_course_progress_summary.dart';
import 'package:gymnastic_center/presentation/widgets/blogs/blogs_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/categories/categories_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/courses/courses_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/shared/custom_appbar.dart';
import 'package:gymnastic_center/presentation/widgets/videos/videos_horizontal_listview.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => getIt<CoursesBloc>()),
        BlocProvider(
            create: (_) => getIt<BlogsBloc>()),
        BlocProvider(
            create: (_) => getIt<CategoriesBloc>()),
        BlocProvider(
            create: (_) => getIt<TrendingProgressBloc>())
      ],
      child: const _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home();

  @override
  State<_Home> createState() => __HomeState();
}

class __HomeState extends State<_Home> {
  @override
  void initState() {
    super.initState();
    context.read<CoursesBloc>().loadNextPage();
    context.read<CategoriesBloc>().loadNextPage();
    context.read<BlogsBloc>().loadNextPage();
    context.read<TrendingProgressBloc>().loadTrendingCourseProgress();
  }

  @override
  Widget build(BuildContext context) {
    final List<Course> courses = context.watch<CoursesBloc>().state.courses;
    final List<Category> categories =
        context.watch<CategoriesBloc>().state.categories;
    final List<Blog> blogs = context.watch<BlogsBloc>().state.loadedBlogs;
    final CourseProgress trendingCourseProgress = context.watch<TrendingProgressBloc>().state.trendingCourseProgress;

    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          automaticallyImplyLeading: false,
          titleSpacing: 20,
          expandedHeight: 160,
          flexibleSpace: CustomAppbar(),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              TredingCourseProgressSummary(trendingCourseProgress),
              CategoriesHorizontalListView(
                  categories: categories, title: 'Category of Yoga'),
              CourseHorizontalListView(
                courses: courses,
                title: 'Popular Courses',
                routeToGo: '/home/0/courses',
              ),
              VideoHorizontalListView(courses: courses, title: 'Resume Videos'),
              BlogHorizontalListView(
                blogs: blogs,
                title: 'Our latest blogs',
                routeToGo: '/home/0/courses',
              ),
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
