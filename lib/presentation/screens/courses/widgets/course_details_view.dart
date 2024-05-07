import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/screens/courses/widgets/custom_icon.dart';
import 'package:gymnastic_center/presentation/screens/courses/widgets/custom_image.dart';
import 'package:gymnastic_center/presentation/widgets/videos/videos_courses_listview.dart';

class CourseDetailsView extends StatelessWidget {

  final Course course;
  const CourseDetailsView({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImage(
          src: course.image,
          instructor: course.instructor,
          title: course.title,
        ),

        // Course Details
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                course.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 12)
                ), 
            ],
          ),
        ),

        const Divider(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIcon(icon: Icons.menu, title: 'Calories', subtitle: course.calories),
            const CustomIcon(
                icon: Icons.calendar_month_outlined,
                title: 'Weeks',
                subtitle: '3'),
            const CustomIcon(
                icon: Icons.watch_later_outlined,
                title: 'Mins',
                subtitle: '22'),
          ],
        ),

        const VideosCoursesListView(
          // lessons: course.lessons!,
          lessons: [],
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}