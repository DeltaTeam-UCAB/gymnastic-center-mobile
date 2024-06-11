import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';

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
