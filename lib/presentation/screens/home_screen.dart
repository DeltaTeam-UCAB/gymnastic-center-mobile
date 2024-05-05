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
    final bool isNotificationsEnabled = context.watch<NotificationsBloc>().state.status;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen - Theme: ${isDark ? 'Dark' : 'Light'}'),
      ),

      body: Center(
        child: Text("Home")
      ),
      
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end, 
        children: [
          FloatingActionButton(
            heroTag: 'ThemeDark',
            onPressed: () {
              context.read<ThemesBloc>().changeTheme();
            },
            child: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
            ),
          ),

          const SizedBox(height: 10),

          FloatingActionButton(
            heroTag: 'RequestPermission',
            onPressed: () {
              context.read<NotificationsBloc>().requestPermission();
            },
            child: const Icon(
              Icons.notifications,
            ),
          ),

          const SizedBox(height: 10),

          FloatingActionButton(
            heroTag: 'goToVideoPlayer',
            onPressed: () {
              context.push('/video-player/e5f0ddf6-814a-42c0-80d9-12b766d53fc1');
            },
            child: const Icon(
              Icons.video_file,
            ),
          ),
        ],
      )
    );
  }
}