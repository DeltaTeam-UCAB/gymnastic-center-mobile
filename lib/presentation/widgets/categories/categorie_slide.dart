import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/presentation/dtos/filter_dto.dart';

class CategorySlide extends StatelessWidget {
  final Category category;

  const CategorySlide({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        color: Colors.white, fontSize: 13, overflow: TextOverflow.ellipsis);
    return GestureDetector(
      onTap: () => context.push('/home/0/courses',
          extra: FilterDto(categoryId: category.id)),
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
                    width: 45,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Image.network(
                          category.icon,
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
                    )),
                Container(
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 63, 59, 102)
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(7)),
                  height: 80,
                  width: 90,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 55, 0, 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 80,
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
