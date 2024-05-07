import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleClipper extends CustomClipper<Rect> {
  const CircleClipper({required this.position, required this.radius});

  final Offset position;
  final double radius;

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: position, radius: radius);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
