import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';

class AllCategoriesSlide extends StatelessWidget {
  final Category category;

  const AllCategoriesSlide({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        color: Colors.white, fontSize: 20, overflow: TextOverflow.ellipsis);
    return GestureDetector(
      onTap: () => context.push('/home/0/courses?category=${category.id}'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                    width: 95,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: CachedNetworkImage(
                          imageUrl: category.icon,
                          fit: BoxFit.cover,
                          //width: 150,
                          progressIndicatorBuilder:
                              (context, url, loadingProgress) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )),
                Container(
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 63, 59, 102)
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(7)),
                  height: 140,
                  width: 150,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 105, 0, 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(
                          category.name,
                          style: titleStyle,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
