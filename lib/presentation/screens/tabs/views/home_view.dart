import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/presentation/widgets/courses/courses_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/posts/posts_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/videos/videos_horizontal_listview.dart';
import 'package:gymnastic_center/presentation/widgets/shared/custom_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Course> courses = [
      Course(
          id: '1',
          title: 'Tadasana Yoga',
          category: 'Yoga',
          released: DateTime.utc(2024, 5, 4),
          image:
              'https://images.ecestaticos.com/gnBzw92jLNdX0ELHqXqKtdX71fM=/152x0:2173x1516/557x418/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Ffde%2F466%2Ff01%2Ffde466f01483ddb15a4d6d9d9cdd97ad.jpg',
          description: 'aaaaaaa',
          calories: 'aaaaa',
          instructor: 'aaaaaa',
          lessons: []),
      Course(
          id: '2',
          title: 'Marvin McKinney',
          category: 'Yoga',
          released: DateTime.utc(2024, 5, 4),
          image:
              'https://www.health.com/thmb/jZUEZBuA4eO7WBWURoOCkxdLGFU=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-1395504255-33d159af773f45039286966a35dfd76d.jpg',
          description: 'aaaaaaa',
          calories: 'aaaaa',
          instructor: 'aaaaaa',
          lessons: []),
      Course(
          id: '3',
          title: 'Abs core',
          category: 'Train',
          released: DateTime.utc(2024, 1, 1),
          image:
              'https://cdn-lagkd.nitrocdn.com/HaBlunxQzwoNVRZDCOMTzKlXBzanMpLU/assets/images/optimized/rev-b4f9958/www.aestheticsmedispa.in/wp-content/uploads/2023/09/Six-Pack-Abs-via-VASER-No-Exercise-Needed-1536x865.jpg',
          description: 'aaaaaaa',
          calories: 'aaaaa',
          instructor: 'aaaaaa',
          lessons: [])
    ];
    final List<Post> posts = [
      Post(
          id: '1',
          title: 'New yoga styles are coming next year 2025',
          body: '',
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
          body: '',
          images: [
            'https://www.foodandwine.com/thmb/dJioehiMBM0IHtF2yqvv4fjrahI=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/A-Feast-of-Apples-FT-2-MAG1123-980271d42b1a489bab239b1466588ca4.jpg'
          ],
          autor: 'Pepe',
          tags: ['Food']),
      Post(
          id: '2',
          title: 'Yoga influencer married',
          released: DateTime.utc(2024, 5, 5),
          body: '',
          images: [
            'https://www.realmenrealstyle.com/wp-content/uploads/2016/06/Sports-and-Attractiveness-athlete-couple-fit.jpg'
          ],
          autor: 'Pepe',
          tags: ['Yoga', 'Lifestyle', 'Healthy', 'Trendy']),
    ];
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          automaticallyImplyLeading: false,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            centerTitle: false,
            titlePadding: EdgeInsets.symmetric(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              // TODO: Add the widgets here.
              CourseHorizontalListView(
                  courses: courses, title: 'Popular Courses'),
              VideoHorizontalListView(courses: courses, title: 'Resume Videos'),
              PostHorizontalListView(posts: posts, title: 'Our latest posts'),
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
