import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/application/courses/course-details/course_details_bloc.dart';
import 'package:gymnastic_center/application/courses/delete-lesson/delete_lesson_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/widgets/shared/delete_popup_menu.dart';

class LessonsAdminScreen extends StatelessWidget {
  final String courseId;
  const LessonsAdminScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CourseDetailsBloc>()..getCourseById(courseId),
        ),
        BlocProvider(
          create: (_) => getIt<DeleteLessonBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lessons Admin'),
        ),
        body: const LessonsAdminView(),
      ),
    );
  }
}

class LessonsAdminView extends StatelessWidget {
  const LessonsAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final refresh = context.read<CourseDetailsBloc>().refreshCourse;
    return BlocListener<DeleteLessonBloc, DeleteLessonState>(
      listener: (context, state) {
        if (state.status == DeleteLessonStatus.deleted) {
          refresh();
        }
      },
      child: BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
        builder: (context, state) {
          if (state.status == CourseDetailsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == CourseDetailsStatus.error) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElasticIn(
                  child: SvgPicture.asset(
                    'assets/search/search-person.svg',
                    width: 450,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Hey! I think something went wrong!',
                    style: TextStyle(fontSize: 20)),
              ],
            ));
          }

          return ListView.separated(
            itemCount: state.course.lessons.length,
            itemBuilder: (context, index) => _LessonSlide(
              lesson: state.course.lessons[index],
              trainer: state.course.trainer.name,
              onDelete: context.read<DeleteLessonBloc>().deleteLesson,
              lessonCount: state.course.lessons.length,
              courseId: state.course.id,
            ),
            separatorBuilder: (context, index) => const Divider(height: 2),
          );
        },
      ),
    );
  }
}

class _LessonSlide extends StatelessWidget {
  final String courseId;
  final int lessonCount;
  final Lesson lesson;
  final String trainer;
  final Future<void> Function(
      {required String lessonId, required String courseId}) onDelete;

  const _LessonSlide(
      {required this.lesson,
      required this.onDelete,
      required this.trainer,
      required this.lessonCount,
      required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(lesson.title),
        subtitle: Text(trainer),
        trailing: lessonCount != 1
            ? DeletePopupMenu(
                onPressed: () => onDelete(
                  lessonId: lesson.id,
                  courseId: courseId,
                ),
                color: Colors.deepPurple,
                dialogTitle: 'Lesson deleted',
                dialogBody: 'Are you sure you want to delete this trainer?',
                dialogAccept: 'Delete',
                dialogDeny: 'Cancel',
                popuplabel: 'Delete trainer',
              )
            : null,
      ),
    );
  }
}
