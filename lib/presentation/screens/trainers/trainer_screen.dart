import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/application/trainers/follow-trainer/follow_trainer_bloc.dart';
import 'package:gymnastic_center/application/trainers/trainer-details/trainer_details_bloc.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/injector.dart';
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
      BlocProvider(create: (_) => getIt<TrainerDetailsBloc>()),
      BlocProvider(create: (_) => getIt<FollowTrainerBloc>()),
      BlocProvider(create: (_) => getIt<CoursesBloc>()),
      BlocProvider(create: (_) => getIt<BlogsBloc>()),
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
    context.read<TrainerDetailsBloc>().loadTrainer(widget.trainerId);
    context.read<CoursesBloc>().loadNextPage(trainerId: widget.trainerId);
    context.read<BlogsBloc>().loadNextPage(trainerId: widget.trainerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final courseState = context.watch<CoursesBloc>().state;
    final blogState = context.watch<BlogsBloc>().state;
    final updateFollowers = context.watch<TrainerDetailsBloc>().updateFollowers;

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
        body: BlocBuilder<TrainerDetailsBloc, TrainerDetailsState>(
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
                    toggleFollow: () async {
                      final result = await context
                          .read<FollowTrainerBloc>()
                          .toggleFollow(widget.trainerId);

                      if (result) {
                        updateFollowers(!state.isFollowing);
                      }
                    },
                    coursesCount: state.courseCount,
                    blogsCount: state.blogCount,
                  ),
                  if (courseState.courses.isNotEmpty)
                    CourseHorizontalListView(
                      courses: courseState.courses,
                      title: 'Look at my Courses',
                      routeToGo: '/home/0/courses?trainer=${widget.trainerId}',
                    ),
                  if (blogState.loadedBlogs.isNotEmpty)
                    BlogHorizontalListView(
                      blogs: blogState.loadedBlogs,
                      title: 'Look at my Blogs',
                      routeToGo: '/home/0/blogs?trainer=${widget.trainerId}',
                    ),
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
    final colors = Theme.of(context).colorScheme;
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
                  child: trainer.image == ''
                      ? Container()
                      : SizedBox(
                          width: 110,
                          height: 110,
                          child: ImageView(image: trainer.image),
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        width: 250,
                        child: ElevatedButton(
                          onPressed: toggleFollow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isFollowing
                                ? colors.inversePrimary
                                : Colors.white,
                          ),
                          child: Text(isFollowing ? 'Following' : 'Follow',
                              style: TextStyle(
                                color: isFollowing
                                    ? Colors.white
                                    : colors.inversePrimary,
                                fontWeight: FontWeight.bold,
                              )),
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
