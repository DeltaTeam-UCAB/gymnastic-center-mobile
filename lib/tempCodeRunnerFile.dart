sManager.onBackgroundMessage(
      firebaseMessagingBackgroundHandler);

  // Initialize Firebase, and pass the default options (firebase_options.dart)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize the local notifications
  await LocalNotifications().initializeLocalNotifications();
  await Environment.