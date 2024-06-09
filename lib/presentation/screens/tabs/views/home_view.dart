import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/datasources/blogs/api_blog_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/courses/api_courses_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blog_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/courses_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/blogs/blogs_horizontal_listview.dart';
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
            create: (_) => CoursesBloc(
                coursesRepository: CoursesRepositoryImpl(
                    ApiCoursesDatasource(LocalStorageService())))),
        BlocProvider(
            create: (_) => BlogsBloc(BlogRepositoryImpl(
                  blogsDatasource: APIBlogDatasource(LocalStorageService()),
                ))),
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
    context.read<BlogsBloc>().loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Course> courses = context.watch<CoursesBloc>().state.courses;
    final List<Blog> blogs = context.watch<BlogsBloc>().state.loadedBlogs;

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
              CourseHorizontalListView(
                  courses: courses, title: 'Popular Courses'),
              VideoHorizontalListView(courses: courses, title: 'Resume Videos'),
              BlogHorizontalListView(blogs: blogs, title: 'Our latest blogs'),
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
