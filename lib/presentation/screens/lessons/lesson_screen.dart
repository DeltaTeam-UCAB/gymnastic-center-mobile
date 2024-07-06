import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/application/courses/lessons/bloc/lessons_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/widgets/comments/comments_section.dart';
import 'package:gymnastic_center/presentation/widgets/courses/lessons_listview.dart';

class LessonScreen extends StatefulWidget {
  final String courseId;
  final String selectedLessonId;

  const LessonScreen(
      {required this.courseId, required this.selectedLessonId, super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {

  @override
  void dispose() {
    getIt.resetLazySingleton<LessonsBloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => getIt<LessonsBloc>()
              ..loadLessonsByCourseId(widget.courseId),
          ),
          BlocProvider(
            create: (_) => getIt<CommentsBloc>()
          ),
        ],
        child: Stack(children: [
          _LesssonView(widget.selectedLessonId),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                titleSpacing: -10,
                title: const Text('Lessons',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                elevation: 0,
              )),
        ]));
  }
}

class _LesssonView extends StatefulWidget {
  final String selectedLessonId;
  const _LesssonView(this.selectedLessonId);

  @override
  State<_LesssonView> createState() => _LesssonViewState();
}

class _LesssonViewState extends State<_LesssonView>
    with TickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);    
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LessonsBloc, LessonsState>(
        buildWhen: (previous, current) =>
            (previous.currentLesson != current.currentLesson) ||
            (previous.status != current.status) ||
            (previous.isFirstLesson != current.isFirstLesson) ||
            (previous.isLastLesson != current.isLastLesson),
        builder: (context, state) {
          if (state.status == LessonsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == LessonsStatus.error) {
            return const Center(
              child: Text('Error has occured'),
            );
          }
          if (state.status == LessonsStatus.changingLesson) {
            context
                .read<LessonsBloc>()
                .changeCurrentLesson(widget.selectedLessonId);
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              _VideoPreview(state.currentLesson),
              TabBar(
                controller: _controller,
                tabs: const [
                Tab(
                  text: 'Description',
                ),
                Tab(
                  text: 'Comments',
                ),
                Tab(
                  text: 'Lesssons',
                )
              ]),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(state.currentLesson.content)),
                    const _CommentsTab(),
                    SingleChildScrollView(
                      child: LessonsListView(
                          lessons: state.lessons,
                          currentLessondId: state.currentLesson.id,
                          onPressedLesson: (lesson) {
                            context
                              .read<LessonsBloc>()
                              .changeCurrentLesson(lesson.id);
                          }
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class _CommentsTab extends StatefulWidget {
  const _CommentsTab();

  @override
  State<_CommentsTab> createState() => _CommentsTabState();
}

class _CommentsTabState extends State<_CommentsTab> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final currentLesson = context.watch<LessonsBloc>().state.currentLesson;
    return CommentsSection(
      onInitialLoadComments: () => context.read<CommentsBloc>().startInitialLoad(currentLesson.id, 'LESSON'),
      onLoadNextComments: () => context.read<CommentsBloc>().loadNextPageById(currentLesson.id, 'LESSON'),
      onPostComment: (message) => context.read<CommentsBloc>().createComment(currentLesson.id, 'LESSON', message), 
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

class _VideoPreview extends StatelessWidget {
  final double _height = 300;
  final Lesson lesson;
  const _VideoPreview(this.lesson);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isFirstLesson = context.read<LessonsBloc>().state.isFirstLesson;
    final isLastLesson = context.read<LessonsBloc>().state.isLastLesson;

    return SizedBox(
      height: _height,
      child: Stack(children: [
        Image.network(
          context.read<LessonsBloc>().state.imgSelectedCourse,
          height: _height,
          fit: BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) return const SizedBox();
            return FadeIn(child: child);
          },
        ),
        Container(
          // height: 400,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  stops: [0.4, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87])),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Text('Watch ${lesson.title}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
        Positioned.fill(
          top: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Row(children: [
                if (!isFirstLesson)
                  _CustomButton(
                      iconData: Icons.arrow_left,
                      onPressed: () {
                        context.read<LessonsBloc>().changeToPreviousLesson();
                      }),
                const Spacer(),
                if (!isLastLesson)
                  _CustomButton(
                      iconData: Icons.arrow_right,
                      onPressed: () {
                        context.read<LessonsBloc>().changeToNextLesson();
                    }
                  ),
              ]),
            ),
          ),
        ),
        Positioned.fill(
          top: 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: IconButton(
                onPressed: () => context.push('/video-player', extra: lesson.video),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(colors.inversePrimary),
                  iconColor: const MaterialStatePropertyAll(Colors.white),
                  iconSize: MaterialStateProperty.all(40.0),
                  minimumSize:
                      MaterialStateProperty.all(const Size(50.0, 50.0)),
                ),
                icon: const Icon(
                  Icons.play_arrow,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final IconData iconData;
  final void Function() onPressed;

  const _CustomButton({
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        ))),
        backgroundColor:
            MaterialStatePropertyAll(colors.background.withOpacity(0.6)),
        iconColor: const MaterialStatePropertyAll(Colors.white),
        iconSize: const MaterialStatePropertyAll(30),
      ),
      icon: Icon(iconData),
    );
  }
}

