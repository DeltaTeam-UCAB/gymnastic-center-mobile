import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String title;
  final String src;
  final String instructor;
  const CustomImage(
      {super.key,
      required this.src,
      required this.instructor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    const customBorderRadius =
        BorderRadius.only(bottomRight: Radius.circular(60));
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: customBorderRadius,
          child: Image.network(
            src,
            height: 400,
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) return const SizedBox();
              return FadeIn(child: child);
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                instructor,
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}