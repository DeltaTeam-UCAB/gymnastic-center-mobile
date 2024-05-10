import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/domain/entities/posts/post.dart';
import 'package:gymnastic_center/presentation/widgets/shared/new_tag.dart';
import 'package:intl/intl.dart';

class PostSlide extends StatelessWidget {
  final Post post;

  const PostSlide({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    var titleStyle = TextStyle(
        height: 1,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black,
        fontSize: 16,
        overflow: TextOverflow.ellipsis);
    var subTitleStyle = TextStyle(
        color: isDark ? Colors.white70 : Colors.black54,
        fontSize: 12,
        overflow: TextOverflow.ellipsis);

    //subtitle formatting
    String subtitle =
        '${DateFormat('mm/dd/yyyy').format(post.released)} - ${post.autor}';

    return GestureDetector(
      onTap: () {
        context.push('/post/${post.id}');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        height: 250,
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
            Text(post.title, style: titleStyle, maxLines: 2),
            const SizedBox(height: 4),
            Text(subtitle, style: subTitleStyle)
          ],
        ),
      ),
    );
  }
}
