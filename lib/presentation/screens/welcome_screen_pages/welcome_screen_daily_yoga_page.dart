import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';

class WelcomeScreenDailyYogaPage extends StatelessWidget {
  const WelcomeScreenDailyYogaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 54),
            child: SvgPicture.asset('assets/welcome/yoga1.svg')),
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 9),
            child: const GradientText(
              textWidget: Text(
                'Yoga',
                style: TextStyle(fontSize: 22),
              ),
              gradient: LinearGradient(
                  colors: [Color(0xff4f14a0), Color(0xff8066ff)],
                  begin: Alignment.topLeft,
                  end: Alignment(0.6, 0.6)),
            )),
        const Text('Daily Yoga',
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold)),
        Container(
            margin: const EdgeInsets.fromLTRB(45, 10, 45, 26),
            child: const Text(
              'Do your practice of physical exercise and relaxation make healthy',
              style: TextStyle(fontSize: 15, color: Color(0xff677294)),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
