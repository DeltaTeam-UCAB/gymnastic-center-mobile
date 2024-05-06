import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';

import 'new_tag.dart';

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
                    return _Slide(post: posts[index]);
                  }))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Post post;

  const _Slide({required this.post});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      height: 1,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 15,
    );
    const subTitleStyle = TextStyle(
        color: Colors.black54, fontSize: 14, overflow: TextOverflow.fade);

    //subtitle formatting
    String subtitle = '';
    for (var tag in post.tags) {
      subtitle = subtitle + tag;
      if (tag != post.tags.last) subtitle = '$subtitle, ';
    }
    if (subtitle.length > 40) {
      subtitle = subtitle.substring(0, 39);
      subtitle = '$subtitle...';
    }

    return GestureDetector(
      onTap: () {
        //TODO: Nav to post
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        height: 300,
        width: 175,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 150,
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      post.images[0],
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
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: NewTag(courseDate: post.released),
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(post.title, style: titleStyle),
            Text(
              subtitle,
              style: subTitleStyle,
              textAlign: TextAlign.left,
            )
          ],
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
