import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EllipseClipper extends CustomClipper<Rect> {
  const EllipseClipper(
      {required this.position, required this.radiusX, required this.radiusY});

  final Offset position;
  final double radiusX;
  final double radiusY;

  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
        center: position, width: radiusX * 2, height: radiusY * 2);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
