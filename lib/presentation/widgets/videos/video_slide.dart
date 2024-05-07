import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';

class VideoSlide extends StatelessWidget {
  final Course course;
  final double height;
  final double width;
  const VideoSlide(
      {super.key,
      required this.course,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: Nav to course screen
      },
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
                    width: width,
                    height: height,
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
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 63, 59, 102)
                            .withOpacity(0.65),
                        borderRadius: BorderRadius.circular(10)),
                    height: height,
                    width: width,
                    child: const Icon(
                      Icons.play_circle_outline_rounded,
                      color: Colors.white,
                      size: 80,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
