import 'package:flutter/material.dart';

class ProgressLessonBar extends StatelessWidget {
  final int percent;
  final Color color;
  
  const ProgressLessonBar({super.key, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {

    return TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeInOut,
        tween: Tween<double>(
            begin: 0,
            end: percent / 100,
        ),
        builder: (context, value, _) =>
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: LinearProgressIndicator(
                value: value,
              ),
            ),
    );
    
  }
}