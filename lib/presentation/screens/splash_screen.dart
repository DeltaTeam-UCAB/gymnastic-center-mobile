import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => context.go('/welcome'));
  }

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
