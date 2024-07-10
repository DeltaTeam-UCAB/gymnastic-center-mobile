import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/suscriptions/suscription/suscription_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/screens/courses/widgets/custom_icon.dart';
import 'package:gymnastic_center/presentation/screens/courses/widgets/custom_image.dart';
import 'package:gymnastic_center/presentation/widgets/courses/lessons_listview.dart';

class CourseDetailsView extends StatelessWidget {
  final Course course;
  const CourseDetailsView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final suscribeStatus = context.watch<SuscriptionBloc>().state.status;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImage(
          src: course.image,
          trainer: course.trainer,
          title: course.title,
          released: course.released,
        ),
        
        // Course Details
        Padding(
          padding:
              const EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('tags: ${course.tags.join(', ')}',
                  style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 5),
              Text(course.description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),

        const Divider(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIcon(
                icon: Icons.menu, title: 'Level', subtitle: course.level),
            CustomIcon(
                icon: Icons.calendar_month_outlined,
                title: 'Weeks',
                subtitle: course.durationWeeks),
            CustomIcon(
                icon: Icons.watch_later_outlined,
                title: 'Mins',
                subtitle: course.durationMinutes),
          ],
        ),

        LessonsListView(
          lessons: course.lessons!,
          onPressedLesson: (lesson) async {
              if ( suscribeStatus == SuscribedStatus.unsuscribed){
                await context.read<SuscriptionBloc>().suscribeToCourse(course.id);
              }
              if ( context.mounted ){
                context.push('/home/0/course/${course.id}/${lesson.id}');
              }
            }
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}
