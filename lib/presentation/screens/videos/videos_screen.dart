import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/widgets/videos/video_slide.dart';

class AllVideosScreen extends StatelessWidget {
  const AllVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double height = 150;
    const double width = 175;
    final List<Course> courses = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Videos',
          style: TextStyle(color: Colors.white, fontFamily: 'PT Sans'),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 27),
                child: Text('Sort by: '),
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  label: const Text('newest'))
            ],
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.05,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return VideoSlide(
                  course: courses[index],
                  height: height,
                  width: width,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
