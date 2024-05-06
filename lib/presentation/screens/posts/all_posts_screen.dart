import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/presentation/widgets/posts/post_slide.dart';

class AllPostsScreen extends StatelessWidget {
  const AllPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = [
      Post(
          id: '1',
          title: 'New yoga styles are coming next year 2025',
          released: DateTime.utc(2024, 5, 5),
          images: [
            'https://newsnetwork.mayoclinic.org/n7-mcnn/7bcc9724adf7b803/uploads/2017/05/two-women-and-a-man-doing-yoga-in-front-of-a-wall-of-windows-in-a-sunny-space-16X9-1024x576.jpg'
          ],
          autor: 'Pepe',
          tags: [
            'Yoga',
            'Lifestyle',
            'Healthy',
            'Trendy',
          ]),
      Post(
          id: '2',
          title: 'Researchers discovered apples are healthy',
          released: DateTime.utc(2024, 1, 1),
          images: [
            'https://www.foodandwine.com/thmb/dJioehiMBM0IHtF2yqvv4fjrahI=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/A-Feast-of-Apples-FT-2-MAG1123-980271d42b1a489bab239b1466588ca4.jpg'
          ],
          autor: 'Pepe',
          tags: ['Food']),
      Post(
          id: '2',
          title: 'Yoga influencer married',
          released: DateTime.utc(2024, 5, 5),
          images: [
            'https://www.realmenrealstyle.com/wp-content/uploads/2016/06/Sports-and-Attractiveness-athlete-couple-fit.jpg'
          ],
          autor: 'Pepe',
          tags: ['Yoga', 'Lifestyle', 'Healthy', 'Trendy']),
    ];
    List<Row> rows = [];
    for (int i = 0; i < posts.length; i++) {
      if (i % 2 == 1) {
        rows.add(Row(children: [
          PostSlide(post: posts[i - 1]),
          PostSlide(post: posts[i])
        ]));
      } else if (i == posts.length - 1) {
        rows.add(Row(
          children: [PostSlide(post: posts[i])],
        ));
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
          style: TextStyle(color: Colors.white, fontFamily: 'PT Sans'),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
        itemCount: rows.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(2, 8, 0, 0),
            child: rows[index],
          );
        },
      ),
    );
  }
}
