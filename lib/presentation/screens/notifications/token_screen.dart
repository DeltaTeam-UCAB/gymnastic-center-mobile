import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/notifications/bloc/notifications_bloc.dart';
import 'package:gymnastic_center/infrastructure/firebase/firebase_notifications_manager.dart';
import 'package:gymnastic_center/infrastructure/local_notifications/local_notifications.dart';

class TokenScreen extends StatelessWidget {
  const TokenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsBloc(
        FirebaseNotificationsManager(LocalNotifications()),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Token Screen'),
        ),
        body: Center(
            child: TextField(
          controller: TextEditingController(
              text:
                  context.select((NotificationsBloc bloc) => bloc.state.token)),
        )),
      ),
    );
  }
}
