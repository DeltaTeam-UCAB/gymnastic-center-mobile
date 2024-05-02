import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        alignment: Alignment.center,
        height: double.infinity,
        child: SvgPicture.asset(
          'assets/splash/splash-screen-bg.svg',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topLeft,
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: SvgPicture.asset('assets/splash/logo-white.svg'),
      )
    ]);
  }
}
