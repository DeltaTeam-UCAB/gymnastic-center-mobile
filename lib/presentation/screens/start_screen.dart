import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/presentation/widgets/shared/custom_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
        LocalStorageService().getValue<String>('token').then((token) {
            if (token != null)
        context.go('/');
        });
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    const textStyle = TextStyle(fontSize: 40, fontWeight: FontWeight.bold);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 150),
          Image.asset(
            isDark
              ? 'assets/icon/logoApp_white.png'
              : 'assets/icon/logoApp_purple.png',
            width: 225,
          ),
          const SizedBox(height: 30),
          const Column(
            children: [
              Text("Welcome to yoga ",style: textStyle),
              Text("Online Class ", style: textStyle,),
            ],
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomButtom(
                onPressed: () => context.go('/login'),
                title: 'Login',
                backgroundColor: isDark ? Colors.white : Colors.deepPurple,
                foregroundColor: isDark ? Colors.deepPurple : Colors.white,
              ),
              CustomButtom(
                onPressed: () => context.go('/register'),
                title: 'Signup',
                backgroundColor: isDark ? Colors.grey : Colors.white,
                foregroundColor: isDark ? Colors.white : Colors.deepPurple,
              ),
            ],
          )
        ],
      )
    );
  }
}
