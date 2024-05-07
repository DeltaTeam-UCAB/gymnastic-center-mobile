import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';

class WelcomeScreenPage extends StatelessWidget {
  const WelcomeScreenPage(
      {required this.svgPictureAssetLocation,
      required this.gradientText,
      required this.titleText,
      required this.descriptionText,
      super.key});

  final String svgPictureAssetLocation;
  final String gradientText;
  final String titleText;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 54),
            child: SvgPicture.asset(svgPictureAssetLocation)),
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 9),
            child: GradientText(
              textWidget: Text(
                gradientText,
                style: const TextStyle(fontSize: 22),
              ),
              gradient: const LinearGradient(
                  colors: [Color(0xff4f14a0), Color(0xff8066ff)],
                  begin: Alignment.topLeft,
                  end: Alignment(0.6, 0.6)),
            )),
        Text(titleText,
            style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold)),
        Container(
            margin: const EdgeInsets.fromLTRB(45, 10, 45, 26),
            child: Text(
              descriptionText,
              style: const TextStyle(fontSize: 15, color: Color(0xff677294)),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}