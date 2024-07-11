import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/presentation/widgets/courses/course_progress_slide.dart';
import 'package:gymnastic_center/presentation/widgets/shared/see_all_button.dart';

class CourseProgressHorizontalListView extends StatelessWidget {
  final List<CourseProgress> courses;
  final String title;
  final String routeToGo;

  const CourseProgressHorizontalListView(
      {super.key,
      required this.courses,
      required this.title,
      required this.routeToGo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          _Title(
            title: title,
            routeToGo: routeToGo,
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: courses.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CourseProgressSlide(course: courses[index]);
                  }))
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final String routeToGo;
  const _Title({required this.title, required this.routeToGo});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineSmall;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          const Spacer(),
          SeeAllButton(route: routeToGo)
        ],
      ),
    );
  }
}
