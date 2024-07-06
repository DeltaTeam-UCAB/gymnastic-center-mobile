import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

class SeeAllButton extends StatelessWidget {
  final String route;
  const SeeAllButton({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    return GestureDetector(
        onTap: () {
          context.push(route);
        },
        child: Row(children: [
          Text(
            'See all',
            style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.deepPurple.shade300 : Colors.black38),
          ),
          Icon(
            size: 14,
            Icons.arrow_forward_ios_rounded,
            color: isDark ? Colors.deepPurple.shade300 : Colors.black38,
          )
        ]));
  }
}
