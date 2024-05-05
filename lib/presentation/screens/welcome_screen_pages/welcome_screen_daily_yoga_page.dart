import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';

class WelcomeScreenDailyYogaPage extends StatelessWidget {
  const WelcomeScreenDailyYogaPage({super.key, this.onNextClicked});

  final Function? onNextClicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        Directionality(
            textDirection: TextDirection.rtl,
            child: FilledButton.icon(
              onPressed: () {
                onNextClicked?.call();
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
            )),
      ],
    );
  }
}
