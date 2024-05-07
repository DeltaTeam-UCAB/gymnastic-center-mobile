import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

class ThemeManagerScreen extends StatelessWidget {
  const ThemeManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Row(children: [
          Text('Theme'),
        ]),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Light'),
            leading: Radio(
              groupValue: isDark,
              value: false,
              onChanged: !isDark
                  ? null
                  : (bool? value) {
                      context.read<ThemesBloc>().changeTheme();
                    },
            ),
          ),
          ListTile(
              title: const Text('Dark'),
              leading: Radio(
                groupValue: isDark,
                value: true,
                onChanged: isDark
                    ? null
                    : (bool? value) {
                        context.read<ThemesBloc>().changeTheme();
                      },
              ))
        ],
      ),
    );
  }
}
