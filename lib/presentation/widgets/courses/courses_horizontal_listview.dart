import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/dtos/filter_dto.dart';
import 'package:gymnastic_center/presentation/widgets/shared/see_all_button.dart';

import 'course_slide.dart';

class CourseHorizontalListView extends StatelessWidget {
  final List<Course> courses;
  final String title;
  final FilterDto? filterDto;

  const CourseHorizontalListView(
      {super.key, required this.courses, required this.title, this.filterDto});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          _Title(
            title: title,
            filterDto: filterDto ?? FilterDto(),
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
                    return CourseSlide(course: courses[index]);
                  }))
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final FilterDto filterDto;
  const _Title({required this.title, required this.filterDto});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineSmall;
    var route = '/home/0/courses';
    if (filterDto.categoryId != null) {
      route = '$route?category=${filterDto.categoryId}';
    }
    if (filterDto.trainerId != null) {
      route = '$route?trainer=${filterDto.trainerId}';
    }
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
          SeeAllButton(route: route)
        ],
      ),
    );
  }
}
