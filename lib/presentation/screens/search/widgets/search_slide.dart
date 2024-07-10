import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

class SearchSlide extends StatelessWidget {
  final String routeToGo;
  final String title;
  final String trainerName;
  final String category;
  final String image;

  const SearchSlide(
      {super.key,
      required this.title,
      required this.trainerName,
      required this.category,
      required this.image,
      required this.routeToGo});

  String truncateText(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.read<ThemesBloc>().isDarkMode;
    return GestureDetector(
      onTap: () => context.push(routeToGo),
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade800 : Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    truncateText(title, 17),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(truncateText(trainerName, 20),
                      style: const TextStyle(fontSize: 13)),
                  Text(truncateText(category, 17),
                      style: const TextStyle(fontSize: 13)),
                ],
              ),
              const Spacer(),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: 150, maxHeight: 100),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                ),
              )
            ],
          )),
    );
  }
}
