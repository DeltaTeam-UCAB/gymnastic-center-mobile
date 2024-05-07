import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/infrastructure/datasources/courses/courses_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/courses_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/courses/courses_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/posts/posts_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/videos/videos_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/shared/custom_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => CoursesBloc(
                coursesRepository: CoursesRepositoryImpl(
                    CoursesDatasourceImpl(LocalStorageService())))
              ..loadNextPage()),
      ],
      child: const _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    final List<Course> courses = context.watch<CoursesBloc>().state.courses;
    final List<Post> posts = [
      Post(
          id: '1',
          title: 'New yoga styles are coming next year 2025',
          released: DateTime.utc(2024, 5, 5),
          images: [
            'https://newsnetwork.mayoclinic.org/n7-mcnn/7bcc9724adf7b803/uploads/2017/05/two-women-and-a-man-doing-yoga-in-front-of-a-wall-of-windows-in-a-sunny-space-16X9-1024x576.jpg'
          ],
          autor: 'Pepe',
          tags: [
            'Yoga',
            'Lifestyle',
            'Healthy',
            'Trendy',
          ],
          body: ''),
      Post(
          id: '2',
          title: 'Researchers discovered apples are healthy',
          released: DateTime.utc(2024, 1, 1),
          images: [
            'https://www.foodandwine.com/thmb/dJioehiMBM0IHtF2yqvv4fjrahI=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/A-Feast-of-Apples-FT-2-MAG1123-980271d42b1a489bab239b1466588ca4.jpg'
          ],
          autor: 'Pepe',
          tags: ['Food'],
          body: ''),
      Post(
          id: '2',
          title: 'Yoga influencer married',
          released: DateTime.utc(2024, 5, 5),
          images: [
            'https://www.realmenrealstyle.com/wp-content/uploads/2016/06/Sports-and-Attractiveness-athlete-couple-fit.jpg'
          ],
          autor: 'Pepe',
          tags: ['Yoga', 'Lifestyle', 'Healthy', 'Trendy'],
          body: ''),
    ];
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          automaticallyImplyLeading: false,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            centerTitle: false,
            titlePadding: EdgeInsets.symmetric(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
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
