import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/widgets/shared/see_all_button.dart';

import 'video_slide.dart';

class VideoHorizontalListView extends StatelessWidget {
  final List<Course> courses;
  final String title;

  const VideoHorizontalListView(
      {super.key, required this.courses, required this.title});

  @override
  Widget build(BuildContext context) {
    const double height = 170;
    const double width = 280;
    return SizedBox(
      height: 240,
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
                    return VideoSlide(
                        course: courses[index], height: height, width: width);
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
          const SeeAllButton(route: '/home/0/videos'),
        ],
      ),
    );
  }
}
