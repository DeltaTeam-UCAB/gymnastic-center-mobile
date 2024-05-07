import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/shared/abstract/background.dart';

/// Colocar esto en la raíz de la pantalla a la que se desea aplicarle el fondo.
/// `child` es lo que va a estar en frente del fondo.
///
/// Crea un fondo con un degradado cualquiera. Se debe especificar el degradado,
/// `gradient`, usando una de las clases de degradados que Flutter ofrece, como
/// `LinearGradient`. O, un degradado personalizado usando alguna clase que herede
/// de `Gradient`.
///
/// Ejemplo:
/// ```dart
/// GradientBackground(
///   gradient: LinearGradient(
///     colors: [
///       Colors.red,
///       Colors.green,
///       Colors.blue,
///     ],
///     begin: Alignment.topLeft,
///     end: Alignment.bottomRight,
///   ),
///   child: Text('Hello world'),
/// );
/// ```
class GradientBackground extends Background {
  const GradientBackground(
      {super.key, required this.gradient, required super.child});

  final Gradient gradient;

  @override
  Widget buildBackground(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Container(color: Colors.white),
    );
  }
}
