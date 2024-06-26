import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/widgets/shared/new_tag.dart';

class CourseSlide extends StatelessWidget {
  final Course course;

  const CourseSlide({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 17,
        overflow: TextOverflow.ellipsis);
    const subTitleStyle = TextStyle(color: Colors.white, fontSize: 14);
    return GestureDetector(
      onTap: () => context.push('/home/0/course/${course.id}'),
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
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 63, 59, 102)
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10)),
                  height: 150,
                  width: 160,
                  child: NewTag(courseDate: course.released),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(13, 5, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          course.title,
                          style: titleStyle,
                          maxLines: 2,
                        ),
                      ),
                      Text(course.category, style: subTitleStyle)
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
