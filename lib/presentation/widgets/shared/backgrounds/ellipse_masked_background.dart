import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gymnastic_center/presentation/widgets/shared/abstract/background.dart';
import 'package:gymnastic_center/presentation/widgets/shared/backgrounds/clippers/ellipse_clipper.dart';

/// Colocar esto en la raíz de la pantalla a la que se desea aplicarle el fondo.
/// `child` es lo que va a estar en frente del fondo.
///
/// Específico de las pantallas relacionadas con autenticación. Véase el Figma
/// para ver cómo luce. `backgroundContent` es el contenido de lo que está fuera
/// de la elipse. `ellipseMaskContent` es el contenido de lo que está dentro de la elipse.
/// Todo lo que esté fuera de la elipse que esté especificado en `ellipseMaskContent`
/// no se verá.
///
/// Parámetros opcionales:
/// - `ellipsePosition`: posición de la elipse, en píxeles, expresado por medio de un `Offset`.
/// - `ellipseRadiusX`: radio horizontal de la elipse, en píxeles.
/// - `ellipseRadiusY`: radio vertical de la elipse, en píxeles.
///
/// Por defecto tendrán los valores justos para que el fondo se vea bien en la pantalla de login.
///
/// Ejemplo:
/// ```dart
/// EllipseMaskedBackground(
///   ellipseMaskContent: Container(
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
class EllipseMaskedBackground extends Background {
  const EllipseMaskedBackground(
      {super.key,
      required this.backgroundContent,
      required this.ellipseMaskContent,
      this.ellipsePosition,
      this.ellipseRadiusX,
      this.ellipseRadiusY,
      required super.child});

  const EllipseMaskedBackground.circle({
    required this.backgroundContent,
    required Widget circleMaskContent,
    Offset? circlePosition,
    double? circleRadius,
    Key? key,
    required Widget child,
  })  : ellipseMaskContent = circleMaskContent,
        ellipsePosition = circlePosition,
        ellipseRadiusX = circleRadius,
        ellipseRadiusY = circleRadius,
        super(key: key, child: child);

  final Widget backgroundContent;
  final Widget ellipseMaskContent;
  final Offset? ellipsePosition;
  final double? ellipseRadiusX;
  final double? ellipseRadiusY;

  @protected
  Offset getEllipsePosition(BuildContext context) {
    if (ellipsePosition != null) {
      return ellipsePosition!;
    } else {
      return Offset(MediaQuery.of(context).size.width / 2,
          MediaQuery.of(context).size.height * 0.826);
    }
  }

  @protected
  double getEllipseRadiusX(BuildContext context) {
    if (ellipseRadiusX != null) {
      return ellipseRadiusX!;
    } else {
      return MediaQuery.of(context).size.width * 1.9028;
    }
  }

  @protected
  double getEllipseRadiusY(BuildContext context) {
    if (ellipseRadiusY != null) {
      return ellipseRadiusX!;
    } else {
      return MediaQuery.of(context).size.height * 0.8692;
    }
  }

  @override
  Widget buildBackground(BuildContext context) {
    return Stack(
      children: [
        backgroundContent,
        ClipOval(
          clipper: EllipseClipper(
              position: getEllipsePosition(context),
              radiusX: getEllipseRadiusX(context),
              radiusY: getEllipseRadiusY(context)),
          child: ellipseMaskContent,
        )
      ],
    );
  }
}
