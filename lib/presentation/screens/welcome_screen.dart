import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('holi',
            style: TextStyle(
                fontFamily: 'PT Sans',
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
