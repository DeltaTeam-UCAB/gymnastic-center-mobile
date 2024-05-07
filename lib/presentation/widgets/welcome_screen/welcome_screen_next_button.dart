import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreenNextButton extends StatelessWidget {
  const WelcomeScreenNextButton({required this.onClickFunction, super.key});

  final void Function() onClickFunction;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: FilledButton.icon(
          onPressed: () {
            onClickFunction();
          },
          style: ElevatedButton.styleFrom(
            maximumSize: const Size(107, 54),
            padding: const EdgeInsets.fromLTRB(16, 14, 11, 14),
            backgroundColor: Colors.white,
            elevation: 20,
            shadowColor: const Color.fromARGB(128, 0, 0, 0),
          ),
          label: const Expanded(
              child: Text(
            'Next',
            style: TextStyle(fontSize: 16, color: Color(0xff222222)),
          )),
          icon: Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: SvgPicture.asset(
                'assets/left-arrow-gradient-circle.svg',
                width: 27,
                height: 27,
              )),
        ));
  }
}
