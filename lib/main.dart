import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/notifications/bloc/notifications_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/infrastructure/firebase/firebase_notifications_manager.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/firebase/firebase_options.dart';
import 'package:gymnastic_center/infrastructure/local_notifications/local_notifications.dart';
import 'package:gymnastic_center/presentation/core/app_widget.dart';

void main() async {
  // Ensure that the WidgetsBinding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Register the background message handler
  FirebaseNotificationsManager.onBackgroundMessage(
      firebaseMessagingBackgroundHandler);

  // Initialize Firebase, and pass the default options (firebase_options.dart)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize the local notifications
  await LocalNotifications().initializeLocalNotifications();
  await Environment.initEnvironment();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => ThemesBloc()),
    BlocProvider(
        create: (_) => NotificationsBloc(
            FirebaseNotificationsManager(LocalNotifications()))),
  ], child: const GymnasticCenterApp()));
}
