import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/blogs/blog.dart';
import 'package:gymnastic_center/presentation/dtos/filter_dto.dart';
import 'package:gymnastic_center/presentation/widgets/shared/see_all_button.dart';

import 'blog_slide.dart';

class BlogHorizontalListView extends StatelessWidget {
  final List<Blog> blogs;
  final String title;
  final FilterDto? filterDto;

  const BlogHorizontalListView(
      {super.key, required this.blogs, required this.title, this.filterDto});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: Column(
        children: [
          _Title(
            title: title,
            filterDto: filterDto,
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: blogs.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BlogSlide(blog: blogs[index]);
                  }))
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final FilterDto? filterDto;
  const _Title({required this.title, this.filterDto});

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
          SeeAllButton(route: '/home/0/blogs', filterDto: filterDto),
        ],
      ),
    );
  }
}
