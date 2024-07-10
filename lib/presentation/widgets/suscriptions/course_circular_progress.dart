import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
class CourseCirularProgress extends StatelessWidget {
  final double height;
  final double width;
  final int percent;
  const CourseCirularProgress({super.key, required this.percent, this.height = 96, this.width = 96});

  Color _getBackgroundColor(ColorScheme colors, bool isDarkMode, int percent){
    if ( percent == 100) return colors.inversePrimary;
    if  (isDarkMode) return colors.background;
    return Colors.white;
  }

  List<Color> _getColorGradient(ColorScheme colors, int percent){
    if  (percent == 100) return [Colors.white, Colors.white];
    return [colors.primary, colors.inversePrimary];
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final Shader gradient = LinearGradient( colors: _getColorGradient(colors,percent)).createShader(const Rect.fromLTWH(200, 0.0, 250.0, 0.0));
    final isDarkMode = context.watch<ThemesBloc>().isDarkMode;
    return Stack(
      children: [
        
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Material(
            color: _getBackgroundColor(colors, isDarkMode, percent),
            elevation: 8,
            child: SizedBox(
                height: height,
                width: width,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1600),
                  curve: Curves.easeInOut,
                  
                  tween: Tween<double>(
                      begin: 0,
                      end: percent / 100,
                  ),
                  builder: (context, value, _) 
                    => CircularProgressIndicator(
                      backgroundColor: const Color.fromARGB(96, 135, 135, 135),
                      color: _getColorGradient(colors,percent)[0],
                      strokeWidth: 16,
                      value: value,
                    ),
                ),
              )
          ),
        ),
        Positioned(
          top: 24,
          height: height,
          width: width,
          child: Text(
              '$percent%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = gradient,
              ),
          ),
        ),
        Positioned(
          top: 52,
          height: height,
          width: width,
          child: Text(
              textAlign: TextAlign.center,
              'Done',
              style: TextStyle(
                fontSize: 16,
                foreground: Paint()..shader = gradient,
              ),
          ),
        )
        
      ],
    );
  }
}