import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/application/profile/profile_bloc.dart';
import 'package:gymnastic_center/application/suscriptions/suscribed-courses/suscribed_courses_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/application/trainers/bloc/trainers_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/widgets/courses/courses_progress_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/shared/image_view.dart';
import 'package:gymnastic_center/presentation/widgets/shared/no_content.dart';
import 'package:gymnastic_center/presentation/widgets/trainers/trainer_horizontal_listview.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemesBloc>().isDarkMode;
    final Client client = context.watch<ClientsBloc>().state.client;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SuscribedCoursesBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<TrainersBloc>(),
        )
      ],
      child: _AccountScreen(client: client, isDarkMode: isDarkMode),
    );
  }
}

class _AccountScreen extends StatefulWidget {
  const _AccountScreen({
    required this.client,
    required this.isDarkMode,
  });

  final Client client;
  final bool isDarkMode;

  @override
  State<_AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<_AccountScreen> {
  @override
  void initState() {
    context.read<SuscribedCoursesBloc>().loadNextPage();
    context.read<TrainersBloc>().loadNextPage(true);
    context.read<ProfileBloc>().loadProfileData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final followingTrainersCount =
        context.watch<ProfileBloc>().state.followingTrainers;
    final suscribedCoursesCount =
        context.watch<ProfileBloc>().state.suscribedCourses;
    final suscribedCourses =
        context.watch<SuscribedCoursesBloc>().state.coursesSuscribed;
    final followingTrainers = context.watch<TrainersBloc>().state.trainers;

    return BlocBuilder<SuscribedCoursesBloc, SuscribedCoursesState>(
      builder: (context, state) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Profile'),
                        GestureDetector(
                          onTap: () => context.push('/account/details'),
                          child: const Icon(Icons.create_sharp),
                        ),
                      ]),
                ],
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(0),
                ),
              ),
            ),
            body: state.status == SuscribedCoursesStatus.loading
                ? const Center(
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator()),
                  )
                : Column(
                    children: [
                      IntrinsicHeight(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(60),
                              )),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    child: widget.client.avatarImage == null
                                        ? const Icon(
                                            Icons.person,
                                            size: 55,
                                          )
                                        : SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: ClipOval(
                                                child: ImageView(
                                                    image: widget
                                                        .client.avatarImage!))),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.client.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () => context.push(
                                                '/home/0/trainers?filteredByFollowed=true'),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '$followingTrainersCount', // USER FOLLOWERS
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                                const Text(
                                                  'following',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 50),
                                          GestureDetector(
                                            onTap: () => context.push(
                                                '/home/0/suscribed-courses'),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '$suscribedCoursesCount', // USER FOLLOWING
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                                const Text(
                                                  'courses',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Row(
                                        children: [
                                          Icon(Icons
                                              .sentiment_dissatisfied_rounded),
                                          SizedBox(
                                            width: 170,
                                          ),
                                          Icon(
                                              Icons.sentiment_satisfied_rounded)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      CustomPaint(
                                        painter:
                                            _GradientProgressIndicatorDrawer(
                                                value: _getGlobalProgress(
                                                    suscribedCourses)),
                                        size: const Size(220, 12),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      suscribedCourses.isNotEmpty
                          ? CourseProgressHorizontalListView(
                              courses: suscribedCourses,
                              routeToGo: '/home/0/suscribed-courses',
                              title: 'My Training',
                            )
                          : const SizedBox(
                              height: 5,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      followingTrainers.isNotEmpty
                          ? TrainerHorizontalListView(
                              trainers: followingTrainers,
                              title: 'My Trainers',
                              routeToGo:
                                  '/home/0/trainers?filteredByFollowed=true')
                          : const SizedBox(
                              height: 5,
                            ),
                      followingTrainers.isEmpty && suscribedCourses.isEmpty
                          ? const NoContent(
                              image: 'assets/stretch.svg',
                              text: "You haven't started courses",
                              height: 150,
                            )
                          : const SizedBox(
                              height: 1,
                            )
                    ],
                  ));
      },
    );
  }
}

class _GradientProgressIndicatorDrawer extends CustomPainter {
  final double value;
  _GradientProgressIndicatorDrawer({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = Colors.purple[900]!;
    canvas.drawRRect(
        RRect.fromLTRBR(
            0, 0, size.width, size.height, const Radius.circular(10)),
        backgroundPaint);

    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.orange, Colors.yellow, Colors.lightGreen, Colors.green],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final roundedRect = RRect.fromLTRBR(
      0,
      0,
      size.width * value,
      size.height,
      const Radius.circular(10),
    );

    canvas.drawRRect(roundedRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

double _getGlobalProgress(List<CourseProgress> courses) {
  if (courses.isEmpty) return 0;
  final list = [];
  for (var element in courses) {
    list.add(element.percent.toDouble());
  }
  double sum = list.reduce((value, element) => value + element);
  double media = sum / list.length;
  return media / 100;
}
