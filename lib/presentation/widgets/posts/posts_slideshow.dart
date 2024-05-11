import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class PostsSlideShow extends StatelessWidget {
  final List<dynamic> posts;
  const PostsSlideShow({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
        height: 300,
        width: double.infinity,
        child: Swiper(
          viewportFraction: 0.75,
          scale: 0.8,
          // autoplay: true,
          itemCount: posts.length,
          pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
              color: colors.secondary,
              activeColor: colors.primary,
            ),
          ),
          itemBuilder: (context, index) => _SlideItem(post: posts[index]),
        ));
  }
}

class _SlideItem extends StatelessWidget {
  final dynamic post;
  const _SlideItem({this.post});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        decoration: BoxDecoration(
            color: colors.onPrimary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                color: Colors.black26,
                offset: Offset(0, 1.5),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Image
            Container(
              height: 180,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://www.webconsultas.com/sites/default/files/styles/wch_image_schema/public/temas/yoga.jpg'),
                    fit: BoxFit.cover,
                  )),
            ),

            //Title
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text('15 Minuts yoga prac tice the beginner in 30 days',
                  style: TextStyle(fontSize: 13)),
            ),

            //Subtitle
            Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Training',
                      style: TextStyle(
                          color: colors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                  Text(
                    'Feb 17, 2020',
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
