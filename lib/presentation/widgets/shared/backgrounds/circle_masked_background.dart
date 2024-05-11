import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gymnastic_center/presentation/widgets/shared/abstract/background.dart';
import 'package:gymnastic_center/presentation/widgets/shared/backgrounds/clippers/circle_clipper.dart';

/// Colocar esto en la raíz de la pantalla a la que se desea aplicarle el fondo.
/// `child` es lo que va a estar en frente del fondo.
///
/// Específico de las pantallas relacionadas con autenticación. Véase el Figma
/// para ver cómo luce. `backgroundContent` es el contenido de lo que está fuera
/// del círculo. `circleMaskContent` es el contenido de lo que está dentro del círculo.
/// Todo lo que esté fuera del círculo que esté especificado en `circleMaskContent`
/// no se verá.
///
/// Parámetros opcionales:
/// - `circlePosition`: posición del círculo, en píxeles, expresado por medio de un `Offset`.
/// - `circleRadius`: radio del círculo, en píxeles.
///
/// Por defecto tendrán los valores justos para que el fondo se vea bien en la pantalla de login.
///
/// Ejemplo:
/// ```dart
/// CircleMaskedBackground(
///   circleMaskContent: Container(
///     alignment: Alignment.center,
///     height: double.infinity,
///     child: SvgPicture.asset(
///       'assets/bg.svg',
///       fit: BoxFit.cover,
///       height: MediaQuery.of(context).size.height,
///       alignment: Alignment.topLeft,
///     ),
///   ),
///   backgroundContent: Container(color: Colors.white),
///   child: const Text('Test')
/// );
/// ```
class CircleMaskedBackground extends Background {
  const CircleMaskedBackground(
      {super.key,
      required this.backgroundContent,
      required this.circleMaskContent,
      this.circlePosition,
      this.circleRadius,
      required super.child});

  final Widget backgroundContent;
  final Widget circleMaskContent;
  final Offset? circlePosition;
  final double? circleRadius;

  @protected
  Offset getCirclePosition(BuildContext context) {
    if (circlePosition != null) {
      return circlePosition!;
    } else {
      return Offset(MediaQuery.of(context).size.width / 2,
          MediaQuery.of(context).size.height * 0.826);
    }
  }

  @protected
  double getCircleRadius(BuildContext context) {
    if (circleRadius != null) {
      return circleRadius!;
    } else {
      return 342;
    }
  }

  @override
  Widget buildBackground(BuildContext context) {
    return Stack(
      children: [
        backgroundContent,
        ClipOval(
          clipper: CircleClipper(
              position: getCirclePosition(context),
              radius: getCircleRadius(context)),
          child: circleMaskContent,
        )
      ],
    );
  }
}
