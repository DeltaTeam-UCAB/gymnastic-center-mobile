import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    final textStyle =
        const TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 130,
          ),
          Image.asset(
            isDark
                ? 'assets/icon/logoApp_white.png'
                : 'assets/icon/logoApp_purple.png',
            width: 225,
          ),
          Text(
            "Welcome to yoga ",
            style: textStyle,
          ),
          Text(
            "Online Class ",
            style: textStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FilledButton(
                  onPressed: () => context.go('/home/0'),
                  child: const Text("Login")),
              FilledButton(
                  onPressed: () => context.go('/home/0'),
                  child: const Text("Signup")),
            ],
          )
        ],
      ),
    ));
  }
}
