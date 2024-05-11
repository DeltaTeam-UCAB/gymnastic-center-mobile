import 'package:flutter/material.dart';

abstract class Background extends StatelessWidget {
  const Background({super.key, required this.child});

  @protected
  Widget buildBackground(BuildContext context);

  @protected
  Widget buildChild(BuildContext context) {
    return child;
  }

  @protected
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(children: [
        buildBackground(context),
        buildChild(context),
      ]),
    );
  }
}
