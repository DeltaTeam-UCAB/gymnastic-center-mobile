import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/application/trainers/trainer_bloc.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/infrastructure/datasources/blogs/api_blog_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/courses/api_courses_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/trainers/api_trainer_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blog_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/courses_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/trainers/trainers_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/blogs/blogs_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/courses/courses_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/shared/image_view.dart';
import 'package:gymnastic_center/presentation/widgets/shared/navigation_bar/custom_bottom_navigation.dart';

class TrainerScreen extends StatelessWidget {
  final String trainerId;
  const TrainerScreen({super.key, required this.trainerId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => TrainerBloc(
          TrainersRepositoryImpl(
            ApiTrainersDatasource(LocalStorageService()),
          ),
        ),
      ),
      BlocProvider(
          create: (_) => CoursesBloc(
              coursesRepository: CoursesRepositoryImpl(
                  ApiCoursesDatasource(LocalStorageService())))),
      BlocProvider(
        create: (_) => BlogsBloc(
          BlogRepositoryImpl(
            blogsDatasource: APIBlogDatasource(LocalStorageService()),
          ),
        ),
      ),
    ], child: TrainerView(trainerId: trainerId));
  }
}

class TrainerView extends StatefulWidget {
  final String trainerId;
  const TrainerView({super.key, required this.trainerId});

  @override
  State<TrainerView> createState() => _TrainerViewState();
}

class _TrainerViewState extends State<TrainerView> {
  @override
  void initState() {
    super.initState();
    context.read<TrainerBloc>().loadTrainer(widget.trainerId);
    context.read<CoursesBloc>().loadNextPage(trainerId: widget.trainerId);
    context.read<BlogsBloc>().loadNextPage(trainerId: widget.trainerId);
  }

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CoursesBloc>().state;
    final blogState = context.watch<BlogsBloc>().state;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: const CustomBottomNavigation(currentIndex: 0),
        appBar: AppBar(
          title: const Text('Trainer Profile'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(0),
            ),
          ),
        ),
        body: BlocBuilder<TrainerBloc, TrainerState>(
          builder: (context, state) {
            if (state.isLoading ||
                courseState.isLoading ||
                blogState.status == BlogStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  _TrainerDetails(
                    trainer: state.trainer,
                    isFollowing: state.isFollowing,
                    toggleFollow: context.read<TrainerBloc>().toggleFollow,
                    coursesCount: courseState.courses.length,
                    blogsCount: blogState.loadedBlogs.length,
                  ),
                  if (courseState.courses.isNotEmpty)
                    CourseHorizontalListView(
                        courses: courseState.courses,
                        title: 'Look at my Courses'),
                  if (blogState.loadedBlogs.isNotEmpty)
                    BlogHorizontalListView(
                        blogs: blogState.loadedBlogs,
                        title: 'Look at my Blogs'),
                ],
              ),
            );
          },
        ));
  }
}

class _TrainerDetails extends StatelessWidget {
  final Trainer trainer;
  final bool isFollowing;
  final int coursesCount;
  final int blogsCount;
  final Future<void> Function() toggleFollow;

  const _TrainerDetails(
      {required this.trainer,
      required this.isFollowing,
      required this.toggleFollow,
      required this.coursesCount,
      required this.blogsCount});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(60),
            )),
        padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const SizedBox(
                    width: 100,
                    child: ImageView(
                      image: 'https://cdn.icon-icons.com/icons2/3551/PNG/512/trainer_man_people_avatar_person_icon_224850.png',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        trainer.name.length > 18
                            ? "${trainer.name.substring(0, 18)}..."
                            : trainer.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _MetricView(
                            metricValue: trainer.followers,
                            description: 'followers',
                          ),
                          _MetricView(
                            metricValue: coursesCount,
                            description: 'courses',
                          ),
                          _MetricView(
                            metricValue: blogsCount,
                            description: 'blogs',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 25,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: toggleFollow,
                          child: Text(
                            isFollowing ? 'Unfollow' : 'Follow',
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricView extends StatelessWidget {
  final int metricValue;
  final String description;
  const _MetricView({required this.metricValue, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$metricValue',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
