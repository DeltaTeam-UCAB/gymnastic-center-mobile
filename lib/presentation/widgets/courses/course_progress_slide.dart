import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/presentation/widgets/suscriptions/progress_lesson_bar.dart';

class CourseProgressSlide extends StatelessWidget {
  final CourseProgress course;

  const CourseProgressSlide({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    const titleStyle = TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 17,
        overflow: TextOverflow.ellipsis);
    return GestureDetector(
      onTap: () => context.push('/home/0/course/${course.courseId}'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                SizedBox(
                    width: 160,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        course.image,
                        fit: BoxFit.cover,
                        //width: 150,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          }
                          return child;
                        },
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.fromLTRB(13, 5, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          course.courseTitle,
                          style: titleStyle,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 150,
                        alignment: Alignment.bottomCenter,
                        child: ProgressLessonBar(
                          percent: course.percent,
                          color: colors.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
