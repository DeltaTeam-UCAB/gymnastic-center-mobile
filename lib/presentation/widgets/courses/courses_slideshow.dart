import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:timeago/timeago.dart' as timeago;

class CoursesSlideShow extends StatelessWidget {
  final List<Course> courses;
  const CoursesSlideShow({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
        height: 270,
        width: double.infinity,
        child: Swiper(
          viewportFraction: 0.75,
          scale: 0.8,
          itemCount: courses.length,
          pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 15),
            builder: DotSwiperPaginationBuilder(
              color: colors.secondary,
              activeColor: colors.inversePrimary,
            ),
          ),
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => context.push('/home/0/course/${courses[index].id}'),
              child: _SlideItem(course: courses[index])),
        ));
  }
}

class _SlideItem extends StatelessWidget {
  final Course course;
  const _SlideItem({required this.course});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = context.read<ThemesBloc>().isDarkMode;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade800 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                color: Colors.black26,
                offset: Offset(0, 1.5),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image
            Container(
              height: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(course.image),
                    fit: BoxFit.cover,
                  )),
            ),

            //Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                course.title,
                style: const TextStyle(fontSize: 13),
                maxLines: 2,
              ),
            ),

            //Subtitle
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(course.category,
                      style: TextStyle(
                          color: colors.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                  Text(
                    timeago.format(course.released),
                    style: TextStyle(color: colors.secondary, fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
