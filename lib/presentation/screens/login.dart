import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

class Login extends StatelessWidget{
  const Login({super.key});
  
  @override
  Widget build(BuildContext context){
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    
    return Scaffold(
      body: Column( crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        const SizedBox(height: 150),
        Image.asset(
          isDark
              ? 'assets/icon/logoApp_white.png'
              : 'assets/icon/logoApp_purple.png',
          width: 225,
        ),
        const SizedBox(height: 30),
      ]),
    );
  }
}