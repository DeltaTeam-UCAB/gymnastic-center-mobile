import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;

  const CustomButtom({super.key, required this.onPressed, required this.title, required this.backgroundColor, required this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor, backgroundColor: backgroundColor,
        minimumSize: const Size(170, 60),
        padding: const EdgeInsets.symmetric(),
        elevation: 20,
        shadowColor: Colors.deepPurple.withOpacity(0.5),
      ),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      );
  }
}