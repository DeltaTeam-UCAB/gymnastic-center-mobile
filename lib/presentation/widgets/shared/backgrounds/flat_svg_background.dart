import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/presentation/widgets/shared/abstract/background.dart';

/// Colocar esto en la raíz de la pantalla a la que se desea aplicarle el fondo.
/// `child` es lo que va a estar en frente del fondo.
///
/// Crea un fondo con una imagen en formato SVG. **Sólo acepta imágenes SVG que estén en algún
/// directorio de `assets` registrado en `pubspec.yaml`.** La imagen se debe proveer como una
/// ubicación de assets en `svgAssetLocation`.
///
/// Adicionalmente posee parámetros opcionales que permiten personalizar un poco el
/// renderizado de la imagen:
/// - `width` y `height`: ancho y alto, respectivamente, que se le va a aplicar a la imagen.
/// - `alignment`: posición de la imagen en el contenedor. Véase la documentación de `Alignment`.
/// - `fit`: define el ajuste de la imagen respecto al contenedor. Véase `BoxFit`.
///
/// Ejemplo:
/// ```dart
/// FlatSvgBackground(
///   svgAssetLocation: 'assets/bg.svg',
///   width: 67, // opcional
///   height: 100, // opcional
///   fit: BoxFit.contain, // opcional
///   alignment: Alignment.topCenter, // opcional
///   child: Text('Hello world!'),
/// );
/// ```
class FlatSvgBackground extends Background {
  const FlatSvgBackground(
      {super.key,
      required this.svgAssetLocation,
      required super.child,
      this.width,
      this.height,
      this.alignment = Alignment.center,
      this.fit = BoxFit.cover});

  final String svgAssetLocation;
  final double? width;
  final double? height;
  final AlignmentGeometry alignment;
  final BoxFit fit;

  @override
  Widget buildBackground(BuildContext context) {
    return SvgPicture.asset(
      svgAssetLocation,
      width: width,
      height: height,
      alignment: alignment,
      fit: fit,
    );
  }
}
