import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/presentation/widgets/shared/see_all_button.dart';
import 'categorie_slide.dart';

class CategoriesHorizontalListView extends StatelessWidget {
  final List<Category> categories;
  final String title;

  const CategoriesHorizontalListView(
      {super.key, required this.categories, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: Column(
        children: [
          _Title(title: title),
          const SizedBox(
            height: 12,
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CategorySlide(category: categories[index]);
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
          const SeeAllButton(route: '/home/0/categories'),
        ],
      ),
    );
  }
}
