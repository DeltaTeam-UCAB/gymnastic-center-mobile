import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ImageView extends StatelessWidget {
  final String image;
  const ImageView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    late ImageProvider imageProvider;

    if (image.startsWith('http')) {
      imageProvider = NetworkImage(image);
    } else {
      imageProvider = MemoryImage(base64Decode(image));
    }
    // TODO: use FadeInImage instead of FadeIn.
    return FadeIn(
      child: Image(
        image: imageProvider,
        fit: BoxFit.cover,
      ),
    );
  }
}
