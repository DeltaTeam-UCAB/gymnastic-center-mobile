import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/videos/videos_courses_listview.dart';

class CourseScreen extends StatelessWidget {
  final String courseId;
  const CourseScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          child: _CourseDetailsView(courseId: courseId),
        ),

        // Appbar
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: const Text('Yoga Basics For Beginners',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              elevation: 0,
            )),
      ],
    ));
  }
}

class _CourseDetailsView extends StatelessWidget {
  const _CourseDetailsView({required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CustomImage('pepe'),

        // Course Details
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Nostrud Lorem laboris commodo cillum consequat tempor incididunt cupidatat eiusmod cillum. Consectetur irure commodo consectetur tempor ad. Culpa pariatur aliqua nisi nisi dolor sint eiusmod labore est consectetur sunt. Excepteur eu cillum exercitation proident.',
                  style: TextStyle(fontSize: 12)),
            ],
          ),
        ),

        Divider(),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _CustomIcon(icon: Icons.menu, title: 'Level', subtitle: '1'),
            _CustomIcon(
                icon: Icons.calendar_month_outlined,
                title: 'Weeks',
                subtitle: '3'),
            _CustomIcon(
                icon: Icons.watch_later_outlined,
                title: 'Mins',
                subtitle: '22'),
          ],
        ),

        VideosCoursesListView(
          lessons: [
            {
              'titulo': 'Lección 1',
              'contenido': 'Contenido de la lección 1',
            },
            {
              'titulo': 'Lección 2',
              'contenido': 'Contenido de la lección 2',
            },
            {
              'titulo': 'Lección 3',
              'contenido': 'Contenido de la lección 3',
            },
          ],
        ),

        SizedBox(height: 100),
      ],
    );
  }
}

class _CustomIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _CustomIcon(
      {required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final textStyles = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: themeColor.withOpacity(0.2),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(icon, color: themeColor),
          ),
        ),
        const SizedBox(width: 5),
        Column(
          children: [
            //Title
            Text(title, style: textStyles.labelSmall),

            //Subtitle
            Text(
              subtitle,
              style: textStyles.labelSmall,
            )
          ],
        )
      ],
    );
  }
}

class _CustomImage extends StatelessWidget {
  final String src;
  const _CustomImage(this.src);

  @override
  Widget build(BuildContext context) {
    const customBorderRadius =
        BorderRadius.only(bottomRight: Radius.circular(60));
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: customBorderRadius,
          child: Image.network(
            'https://www.futurefit.co.uk/wp-content/uploads/2021/11/Personal-trainer-helping-with-form-scaled.jpg',
            height: 400,
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) return const SizedBox();
              return FadeIn(child: child);
            },
          ),
        ),

        // Gradiente
        Container(
          height: 400,
          decoration: const BoxDecoration(
              borderRadius: customBorderRadius,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87])),
        ),

        // Title
        Positioned(
          bottom: 20,
          left: 20,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Text(
              'Course Title',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}