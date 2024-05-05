import 'package:flutter/material.dart';

/// Aplica un degradado a un widget de texto.
///
/// Ejemplo:
/// ```dart
/// GradientText(
///   textWidget: Text('Hello world'),
///   gradient: LinearGradient: const LinearGradient(colors: [
///       Colors.red,
///       Colors.green,
///       Colors.blue,
///     ],
///     begin: Alignment.topLeft,
///     end: Alignment.bottomRight,
///   )
/// )
/// ```
class GradientText extends StatelessWidget {
  const GradientText({
    required this.textWidget,
    required this.gradient,
    super.key,
  });

  final Text textWidget;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: textWidget,
    );
  }
}
