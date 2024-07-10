import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/courses/lessons/bloc/lessons_bloc.dart';
import 'package:gymnastic_center/application/suscriptions/course-progress/course_progress_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/presentation/widgets/suscriptions/progress_lesson_bar.dart';

class LessonsProgressListView extends StatefulWidget {
  final void Function(
    Lesson lesson
  ) onPressedLesson;
  final List<Lesson> lessons;
  final List<LessonsProgress> lessonsProgress;
  final String? currentLessondId;
  LessonsProgressListView({
    Key? key,
    required this.lessons,
    required this.lessonsProgress,
    required this.onPressedLesson,
    this.currentLessondId
  }) : super(key: key) {
    lessons.sort((a, b) => a.order.compareTo(b.order));
  }

  @override
  State<LessonsProgressListView> createState() => _LessonsProgressListViewState();
}

class _LessonsProgressListViewState extends State<LessonsProgressListView> {
  late List<bool> _expansionStates;

  @override
  void initState() {
    super.initState();
    _expansionStates = List.generate(widget.lessons.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme.titleMedium;
    final percentStyle = Theme.of(context).textTheme.bodySmall;
    final courseId = context.read<LessonsBloc>().state.selectedCourseId;

    
    final colors = Theme.of(context).colorScheme;
    return Column(
      children: [
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Lessons of the course',
              style: textStyles,
            ),
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.lessons.length,
          itemBuilder: (context, index) {
            final lesson = widget.lessons[index];
            final lessonProgress = widget.lessonsProgress.firstWhere((lp) => lp.lessonId == lesson.id);
            return ExpansionPanelList(
                  expansionCallback: (panelIndex, expanded) {
                    setState(() {
                      _expansionStates[index] = !_expansionStates[index];
                    });
                  },
                  children: [
                    
                    ExpansionPanel(
                      backgroundColor: 
                        (lesson.id == widget.currentLessondId) 
                        ? colors.inversePrimary
                        : Colors.transparent
                      ,
                      headerBuilder: (context, isExpanded) {
                        
                        return Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  const Icon(Icons.video_library),
                                  const SizedBox(width: 8,),
                                  Text(lesson.title),
                                  const Spacer(),
                                  if ( widget.currentLessondId == lesson.id )
                                  Text(
                                    '${lessonProgress.percent}%',
                                    style: percentStyle,
                                  ),
                                ],
                              ),
                              // leading: const Icon(Icons.video_library),
                              leading: Checkbox(
                                    value: lessonProgress.percent == 100,
                                    onChanged: (_) {
                                      if (lessonProgress.percent != 100) {
                                        context.read<CourseProgressBloc>().markCompletedLesson(courseId, lesson.id);
                                      }
                                    },
                                  ),
                            ),
                            if ( widget.currentLessondId == lesson.id )
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.elasticInOut,
                                  child: ProgressLessonBar(
                                    color: Colors.white,
                                    percent: lessonProgress.percent
                                  ),
                                ),
                            ),
                          ],
                        );
                      },
                      body: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                              onPressed: () {
                                widget.onPressedLesson(lesson);
                              },
                              icon: const Icon(Icons.play_circle_fill),
                              label: Text(lesson.content))),
                      isExpanded: _expansionStates[index],
                      canTapOnHeader: true,
                    ),
                    
                  ],
                );
          },
        ),
      ],
    );
  }
}

