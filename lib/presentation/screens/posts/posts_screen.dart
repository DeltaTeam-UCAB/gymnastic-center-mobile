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
          ], body: ''),
      Post(
          id: '2',
          title: 'Researchers discovered apples are healthy',
          released: DateTime.utc(2024, 1, 1),
          images: [
            'https://www.foodandwine.com/thmb/dJioehiMBM0IHtF2yqvv4fjrahI=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/A-Feast-of-Apples-FT-2-MAG1123-980271d42b1a489bab239b1466588ca4.jpg'
          ],
          autor: 'Pepe',
          tags: ['Food'], body: ''),
      Post(
          id: '2',
          title: 'Yoga influencer married',
          released: DateTime.utc(2024, 5, 5),
          images: [
            'https://www.realmenrealstyle.com/wp-content/uploads/2016/06/Sports-and-Attractiveness-athlete-couple-fit.jpg'
          ],
          autor: 'Pepe',
          tags: ['Yoga', 'Lifestyle', 'Healthy', 'Trendy'], body: ''),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts',
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostSlide(post: posts[index]);
            },
          )),
        ],
      ),
    );
  }
}
