import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/notifications/bloc/notifications_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.watch<ThemesBloc>().isDarkMode;
    final bool isNotificationsEnabled =
        context.watch<NotificationsBloc>().state.status;

    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen - Theme: ${isDark ? 'Dark' : 'Light'}'),
        ),
        body: Center(
          child: Text(
              'Notifications are ${isNotificationsEnabled ? 'enabled' : 'disabled'}'),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.push('/test');
              },
              child: Icon(
                isDark ? Icons.light_mode : Icons.dark_mode,
              ),
            ),
            const SizedBox(height: 10),
            /*
          FloatingActionButton(
            onPressed: () {
              context.read<NotificationsBloc>().requestPermission();
            },
            child: const Icon(
              Icons.notifications,
            ),
          ),
          */
          ],
        ));
  }
}
