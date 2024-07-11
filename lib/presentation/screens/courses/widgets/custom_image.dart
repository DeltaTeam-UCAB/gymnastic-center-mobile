import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/presentation/widgets/shared/new_tag.dart';

class CustomImage extends StatelessWidget {
  final String title;
  final String src;
  final Trainer trainer;
  final DateTime released;
  const CustomImage(
      {super.key,
      required this.src,
      required this.trainer,
      required this.title,
      required this.released});

  @override
  Widget build(BuildContext context) {
    const customBorderRadius =
        BorderRadius.only(bottomRight: Radius.circular(60));
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: customBorderRadius,
          child: CachedNetworkImage(
            imageUrl: src,
            height: 400,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, loadingProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),

        // Gradiente
        Container(
          height: 400,
          decoration: const BoxDecoration(
              borderRadius: customBorderRadius,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87])),
        ),

        // Title
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => context.push('/home/0/trainer/${trainer.id}'),
                child: Text(
                  trainer.name,
                  style: TextStyle(
                      color: Colors.deepPurple.shade200,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        // Tag New
        Positioned(
          top: 100,
          left: 10,
          child: NewTag(courseDate: released, width: 90, height: 35),
        ),
      ],
    );
  }
}
