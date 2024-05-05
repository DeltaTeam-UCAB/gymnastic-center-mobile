import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/widgets/courses/courses_horizontal_listview.dart';

class HomeFeedScreen extends StatelessWidget {
  const HomeFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: get curses with provider
    final List<Course> courses = [
      Course(
          id: 1,
          name: 'Tadasana Yoga',
          category: 'Yoga',
          released: DateTime.utc(2024, 5, 4),
          image:
              'https://images.ecestaticos.com/gnBzw92jLNdX0ELHqXqKtdX71fM=/152x0:2173x1516/557x418/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Ffde%2F466%2Ff01%2Ffde466f01483ddb15a4d6d9d9cdd97ad.jpg'),
      Course(
          id: 2,
          name: 'Marvin McKinney',
          category: 'Yoga',
          released: DateTime.utc(2024, 5, 4),
          image:
              'https://www.health.com/thmb/jZUEZBuA4eO7WBWURoOCkxdLGFU=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-1395504255-33d159af773f45039286966a35dfd76d.jpg'),
      Course(
          id: 3,
          name: 'Abs core',
          category: 'Train',
          released: DateTime.utc(2024, 1, 1),
          image:
              'https://cdn-lagkd.nitrocdn.com/HaBlunxQzwoNVRZDCOMTzKlXBzanMpLU/assets/images/optimized/rev-b4f9958/www.aestheticsmedispa.in/wp-content/uploads/2023/09/Six-Pack-Abs-via-VASER-No-Exercise-Needed-1536x865.jpg')
    ];
    return Column(
      children: [
        CourseHorizontalListView(courses: courses, title: 'Popular Process')
      ],
    );
  }
}
