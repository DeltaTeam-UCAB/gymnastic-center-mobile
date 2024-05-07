import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'course_slide.dart';

class CourseHorizontalListView extends StatelessWidget {
  final List<Course> courses;
  final String title;

  const CourseHorizontalListView(
      {super.key, required this.courses, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          _Title(title: title),
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
                    return CourseSlide(course: courses[index]);
                  }))
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({required this.title});

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
          GestureDetector(
              onTap: () {
                context.push('/home/0/courses');
              },
              child: const Row(children: [
                Text(
                  'See all',
                  style: TextStyle(fontSize: 14, color: Colors.black38),
                ),
                Icon(
                  size: 14,
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black38,
                )
              ])),
        ],
      ),
    );
  }
}
