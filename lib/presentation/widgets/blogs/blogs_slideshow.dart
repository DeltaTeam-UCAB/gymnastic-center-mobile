import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlogsSlideShow extends StatelessWidget {
  final List<Blog> blogs;
  const BlogsSlideShow({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
        height: 270,
        width: double.infinity,
        child: Swiper(
          viewportFraction: 0.75,
          scale: 0.8,
          itemCount: blogs.length,
          pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 15),
            builder: DotSwiperPaginationBuilder(
              color: colors.secondary,
              activeColor: colors.inversePrimary,
            ),
          ),
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => context.push('/blog/${blogs[index].id}'),
              child: _SlideItem(blog: blogs[index])),
        ));
  }
}

class _SlideItem extends StatelessWidget {
  final Blog blog;
  const _SlideItem({required this.blog});

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
                    image: NetworkImage(blog.images[0]),
                    fit: BoxFit.cover,
                  )),
            ),

            //Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(blog.title,
                  style: const TextStyle(fontSize: 13), maxLines: 2),
            ),

            //Subtitle
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(blog.category,
                      style: TextStyle(
                          color: colors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                  Text(
                    timeago.format(blog.released),
                    style: TextStyle(color: colors.secondary, fontSize: 11),
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
