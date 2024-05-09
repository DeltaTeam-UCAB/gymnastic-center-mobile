import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/shared/abstract/background.dart';

/// Colocar esto en la raíz de la pantalla a la que se desea aplicarle el fondo.
/// `child` es lo que va a estar en frente del fondo.
///
/// Este es el fondo más simple. Especifica un color, `color`, y creará un fondo de
/// ese color.
///
/// Ejemplo:
/// ```dart
/// FlatColorBackground(
///   color: Colors.green,
///   child: Text('Hello world!'),
/// );
/// ```
class FlatColorBackground extends Background {
  const FlatColorBackground(
      {super.key, required this.color, required super.child});

  final Color color;

  @override
  Widget buildBackground(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
