import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/widgets/courses/course_slide.dart';

class AllCoursesScreen extends StatelessWidget {
  const AllCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Course> courses = [
      Course(
          id: '1',
          title: 'Tadasana Yoga',
          category: 'Yoga',
          released: DateTime.utc(2024, 5, 4),
          image:
              'https://images.ecestaticos.com/gnBzw92jLNdX0ELHqXqKtdX71fM=/152x0:2173x1516/557x418/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Ffde%2F466%2Ff01%2Ffde466f01483ddb15a4d6d9d9cdd97ad.jpg',
          description: 'aaaaaaa',
          calories: 'aaaaa',
          instructor: 'aaaaaa',
          lessons: []),
      Course(
          id: '2',
          title: 'Marvin McKinney',
          category: 'Yoga',
          released: DateTime.utc(2024, 5, 4),
          image:
              'https://www.health.com/thmb/jZUEZBuA4eO7WBWURoOCkxdLGFU=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-1395504255-33d159af773f45039286966a35dfd76d.jpg',
          description: 'aaaaaaa',
          calories: 'aaaaa',
          instructor: 'aaaaaa',
          lessons: []),
      Course(
          id: '3',
          title: 'Abs core',
          category: 'Train',
          released: DateTime.utc(2024, 1, 1),
          image:
              'https://cdn-lagkd.nitrocdn.com/HaBlunxQzwoNVRZDCOMTzKlXBzanMpLU/assets/images/optimized/rev-b4f9958/www.aestheticsmedispa.in/wp-content/uploads/2023/09/Six-Pack-Abs-via-VASER-No-Exercise-Needed-1536x865.jpg',
          description: 'aaaaaaa',
          calories: 'aaaaa',
          instructor: 'aaaaaa',
          lessons: [])
    ];
    List<Row> rows = [];
    for (int i = 0; i < courses.length; i++) {
      if (i % 2 == 1) {
        rows.add(Row(children: [
          CourseSlide(course: courses[i - 1]),
          CourseSlide(course: courses[i])
        ]));
      } else if (i == courses.length - 1) {
        rows.add(Row(
          children: [CourseSlide(course: courses[i])],
        ));
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Courses',
          style: TextStyle(color: Colors.white, fontFamily: 'PT Sans'),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text('       Sort by: '),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  label: const Text('newest'))
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: rows.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(11, 8, 8, 8),
                  child: rows[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
