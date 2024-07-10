import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/suscriptions/courses-suscriptions/courses_suscriptions_bloc.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/widgets/shared/delete_popup_menu.dart';
import 'package:gymnastic_center/presentation/widgets/suscriptions/progress_lesson_bar.dart';

class CoursesSuscriptionScreen extends StatelessWidget {
  const CoursesSuscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CoursesSuscriptionsBloc>(),
      child: const _CoursesSuscriptionView(),
    );
  }
}

class _CoursesSuscriptionView extends StatefulWidget {
  const _CoursesSuscriptionView();

  @override
  State<_CoursesSuscriptionView> createState() => _CoursesSuscriptionViewState();
}

class _CoursesSuscriptionViewState extends State<_CoursesSuscriptionView> {
  final ScrollController _scrollController = ScrollController();
    @override
    void initState() {
      super.initState();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels + 60 >=
            _scrollController.position.maxScrollExtent) {
          context.read<CoursesSuscriptionsBloc>().loadNextPage();
        }
      });
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
              titleSpacing: -10,
              title: const Text('Suscribed Courses'),
              elevation: 0,
            ),
      body: BlocBuilder<CoursesSuscriptionsBloc, CoursesSuscriptionsState>(
        builder: (context, state) {
          if (state.status == CoursesSuscriptionsStatus.initial){
            context.read<CoursesSuscriptionsBloc>().initialLoading();
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == CoursesSuscriptionsStatus.error){
            return const Center(
              child: Text('A error has occured'),
            );
          }
          if (state.coursesSuscribed.isEmpty){
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 420,
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/icon/courses_suscribed_empty.png',
                      height: 256,
                      width: 256,
                    
                    ),
                  ),
                  const Text(
                    'Take the first step! Explore our courses and discover a world of possibilities to get in shape',
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: state.coursesSuscribed.length + 1,
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            itemBuilder: (context, index) {
              if ( index == state.coursesSuscribed.length) {
                if (state.status == CoursesSuscriptionsStatus.loading) {
                  return const SizedBox(
                    height: 64,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  
                }
                return const SizedBox(height: 64);
              }
              final courseSuscribed = state.coursesSuscribed[index];
              return _CourseSuscribedSlide(
                onPressed: () => context.read<CoursesSuscriptionsBloc>().unsuscribeCourse(courseSuscribed.courseId),
                course: courseSuscribed,
                height: 240,
                width: double.infinity,
              );
            },
          );
        },
      ),
    );
  }
}

class _CourseSuscribedSlide extends StatelessWidget {
  final CourseProgress course;
  final double height;
  final double width;
  final void Function() onPressed;
  const _CourseSuscribedSlide(
      {
      required this.course,
      required this.height,
      required this.width,
      required this.onPressed
      });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        context.push('/course/${course.courseId}/no-lesson');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox(
                width: width,
                height: height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    course.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }
                      return child;
                    },
                  ),
                )),
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.4, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black87]))
                      ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 82,
              width: width,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        course.courseTitle,
                        style: TextStyle(
                          fontSize: textTheme.titleLarge!.fontSize,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(
                      course.trainer,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.deepPurple.shade200,
                      ),
                    ),
                    const Spacer()
                  ],
                )
              ), 
              Container(
                height: height,
                width: width,
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProgressLessonBar(
                    percent: course.percent,
                    color: colors.primary,
                  )
                ),
              ),
              Container(
                height: height,
                width: width,
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,8,16),
                  child: Text(
                    '${course.percent}%',
                  )
                ),
              ),
              Container(
                height: height,
                width: width,
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,8,16),
                  child: DeletePopupMenu(
                    onPressed: onPressed,
                    color: colors.primary,
                    dialogTitle: 'Do you want to unsubscribe?',
                    dialogBody: 'You will lose all the progress of the course ${course.courseTitle}',
                    dialogDeny: 'forget it',
                    dialogAccept: 'Yes, please',
                    popuplabel: 'Unsuscribe',
                  )
                ),
              )

              
          ],
        ),
      ),
    );
  }
}



