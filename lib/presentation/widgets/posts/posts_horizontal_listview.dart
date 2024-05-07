import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'post_slide.dart';

class PostHorizontalListView extends StatelessWidget {
  final List<Post> posts;
  final String title;

  const PostHorizontalListView(
      {super.key, required this.posts, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: Column(
        children: [
          _Title(title: title),
          const SizedBox(
            height: 12,
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: posts.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PostSlide(post: posts[index]);
                  }))
        ],
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
                context.push('/home/0/posts');
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
