import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const CustomIcon(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final isDarkMode = context.watch<ThemesBloc>().isDarkMode;
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey : Colors.deepPurple.shade50,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(icon,
                color: isDarkMode ? Colors.white : Colors.deepPurple),
          ),
        ),
        const SizedBox(width: 5),
        Column(
          children: [
            //Title
            Text(title, style: textStyles.labelSmall),

            //Subtitle
            Text(
              subtitle,
              style: textStyles.labelSmall,
            )
          ],
        )
      ],
    );
  }
}
