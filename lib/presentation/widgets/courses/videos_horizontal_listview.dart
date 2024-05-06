import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';

class VideoHorizontalListView extends StatelessWidget {
  final List<Course> courses;
  final String title;

  const VideoHorizontalListView(
      {super.key, required this.courses, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
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
                    return _Slide(course: courses[index]);
                  }))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Course course;

  const _Slide({required this.course});

  @override
  Widget build(BuildContext context) {
    //const titleStyle = TextStyle(
    //fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17);
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
                    width: 275,
                    height: 175,
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
                    height: 175,
                    width: 275,
                    child: const Icon(
                      Icons.play_circle_outline_rounded,
                      color: Colors.white,
                      size: 80,
                    )),
                Container(
                  padding: const EdgeInsets.fromLTRB(13, 5, 0, 10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Text(
                        course.name,
                        style: titleStyle,
                      )*/
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

class NewButton extends StatelessWidget {
  final DateTime courseDate;
  const NewButton({
    super.key,
    required this.courseDate,
  });

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    if (today.difference(courseDate) > const Duration(days: 15)) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: 25,
        width: 60,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(115, 81, 230, 1),
              borderRadius: BorderRadius.circular(20)),
          child: const Text(
            'New',
            style: TextStyle(color: Colors.white),
          ),
        ),
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
                //TODO: Nav to paginated courses
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
