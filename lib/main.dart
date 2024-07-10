import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/auth/recover_password/recover_password_bloc.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/application/notifications/bloc/notifications_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/firebase/firebase_notifications_manager.dart';
import 'package:gymnastic_center/infrastructure/firebase/firebase_options.dart';
import 'package:gymnastic_center/infrastructure/local_notifications/local_notifications.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/core/app_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gymnastic_center/infrastructure/extensions/hive_cache.dart';

void main() async {
  // Ensure that the WidgetsBinding is initializedz
  WidgetsFlutterBinding.ensureInitialized();

  // Register the background message handler
  FirebaseNotificationsManager.onBackgroundMessage(
      firebaseMessagingBackgroundHandler);

  // Initialize Firebase, and pass the default options (firebase_options.dart)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize the local notifications
  await LocalNotifications().initializeLocalNotifications();
  await Environment.initEnvironment();

  await Hive.initForCache();
  Hive.registerTypeAdapters();

  // Register Blocs in service locator
  Injector().setUp();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => getIt<ThemesBloc>()),
    BlocProvider(create: (_) => getIt<NotificationsBloc>()),
    BlocProvider(create: (_) => getIt<ClientsBloc>()),
    BlocProvider(create: (_) => getIt<RecoverPasswordBloc>()),
    BlocProvider(create: (_) => getIt<CoursesBloc>()),
    BlocProvider(create: (_) => getIt<BlogsBloc>()),
  ], child: const GymnasticCenterApp()));
}
