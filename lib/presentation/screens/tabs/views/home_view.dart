import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/categories/bloc/categories_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/application/posts/bloc/posts_bloc.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/infrastructure/datasources/categories/categories_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/datasources/courses/api_courses_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/posts/api_post_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/categories/categories_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/courses_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/posts/post_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/categories/categories_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/courses/courses_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/posts/posts_horizontal_listview.dart';
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
            create: (_) => PostsBloc(PostRepositoryImpl(
                  postsDatasource: APIPostDatasource(LocalStorageService()),
                ))),
        BlocProvider(
            create: (_) => CategoriesBloc(
                categoryRepository: CategoriesRespositoryImpl(
                    categoryDatasource:
                        CategoriesDatasourceImpl(LocalStorageService()))))
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
    context.read<PostsBloc>().loadNextPage();
    context.read<CategoriesBloc>().loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final List<Course> courses = context.watch<CoursesBloc>().state.courses;
    final List<Post> posts = context.watch<PostsBloc>().state.loadedPosts;
    final List<Category> categories =
        context.watch<CategoriesBloc>().state.categories;

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
              CategoriesHorizontalListView(
                  categories: categories, title: 'Category of Yoga'),
              CourseHorizontalListView(
                  courses: courses, title: 'Popular Courses'),
              VideoHorizontalListView(courses: courses, title: 'Resume Videos'),
              PostHorizontalListView(posts: posts, title: 'Our latest posts'),
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
