import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/presentation/widgets/shared/backgrounds/flat_svg_background.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';

class PasswordChangedScreen extends StatefulWidget {
  const PasswordChangedScreen({super.key});

  @override
  PasswordChangedScreenState createState() => PasswordChangedScreenState();
}

class PasswordChangedScreenState extends State<PasswordChangedScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _textFieldPadding(Widget child,
      {bool bottom = true, bool top = true}) {
    double paddingValue = MediaQuery.of(context).size.height * 0.022;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            0, top ? paddingValue : 0, 0, bottom ? paddingValue : 0),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = MediaQuery.of(context).size.width * 0.0444;

    return Scaffold(
        body: FlatSvgBackground(
            alignment: Alignment.topLeft,
            height: MediaQuery.of(context).size.height,
            svgAssetLocation: 'assets/splash/splash-screen-bg.svg',
            child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      horizontalPadding, 0, horizontalPadding, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _textFieldPadding(
                            const Text('Password changed',
                                style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            top: false),
                        _textFieldPadding(
                            const Text(
                              'Congratulations! You have successfully changed your password.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            top: false),
                        _textFieldPadding(SvgPicture.asset(
                            'assets/check-white.svg',
                            width: MediaQuery.of(context).size.width * 0.444)),
                        Row(children: [
                          Expanded(
                              child: FilledButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(),
                            ),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0,
                                    MediaQuery.of(context).size.height * 0.0192,
                                    0,
                                    MediaQuery.of(context).size.height *
                                        0.0192),
                                child: const GradientText(
                                    textWidget: Text('Back to login',
                                        style: TextStyle(fontSize: 20)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xff4f14a0),
                                          Color(0xff8066ff),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight))),
                          ))
                        ]),
                      ]),
                ))));
  }
}
