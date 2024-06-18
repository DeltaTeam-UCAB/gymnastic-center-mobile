import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';

class WelcomeScreenPage extends StatelessWidget {
  const WelcomeScreenPage(
      {required this.svgPictureAssetLocation,
      required this.svgPictureDarkAssetLocation,
      required this.gradientText,
      required this.titleText,
      required this.descriptionText,
      super.key});

  final String svgPictureAssetLocation;
  final String svgPictureDarkAssetLocation;
  final String gradientText;
  final String titleText;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemesBloc>().isDarkMode;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 54),
            child: SvgPicture.asset(isDarkMode
                ? svgPictureDarkAssetLocation
                : svgPictureAssetLocation)),
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 9),
            child: GradientText(
              textWidget: Text(
                gradientText,
                style: const TextStyle(fontSize: 22),
              ),
              gradient: LinearGradient(
                  colors: isDarkMode
                      ? [Colors.white, Colors.white]
                      : [const Color(0xff4f14a0), const Color(0xff8066ff)],
                  begin: Alignment.topLeft,
                  end: const Alignment(0.6, 0.6)),
            )),
        Text(titleText,
            style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold)),
        Container(
            margin: const EdgeInsets.fromLTRB(45, 10, 45, 26),
            child: Text(
              descriptionText,
              style: TextStyle(
                  fontSize: 15,
                  color: isDarkMode ? Colors.white : const Color(0xff677294)),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
