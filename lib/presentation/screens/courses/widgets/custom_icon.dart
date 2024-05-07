import 'package:flutter/material.dart';

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
    final themeColor = Theme.of(context).primaryColor;
    final textStyles = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: themeColor.withOpacity(0.2),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(icon, color: themeColor),
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
