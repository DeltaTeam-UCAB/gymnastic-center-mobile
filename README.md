# Gymnastic Center

Gymnastic Center is an Android app developed in Flutter that promotes physical and mental wellness through guided meditation and yoga courses.

## Team Members

All the team members are students of the Software Engineering career at the Universidad Católica Andrés Bello in Caracas, Venezuela. All of them are passionate about technology and software development.

- [Gianfranco Lanza](https://github.com/GianL22)
- [Alejandro Molina](https://github.com/Alejo-FM)
- [Gian P. Astorino](https://github.com/GianPX)
- [Eduardo García](https://github.com/HappyGick)

## Features
Among the most important features of the application we have:

- User registration and access to the application.
- The application must have the ability to search for content.
- A record of the use of the application by the user must be kept.
- The application must have integrated Push Notifications that will be used for different functionalities.
lities

## How It Looks

This section will give you an overview of what the application looks like.

![image](https://github.com/DeltaTeam-UCAB/gymnastic-center-mobile/blob/readme/public/example-1.jpeg) ![image](https://github.com/DeltaTeam-UCAB/gymnastic-center-mobile/blob/readme/public/example-2.jpeg) ![image](https://github.com/DeltaTeam-UCAB/gymnastic-center-mobile/blob/readme/public/example-1.jpeg)

## Getting Started

### Installation
1. Clean the dependencies
```bash
flutter clean
```

2. Get the dependencies
```bash
flutter pub get
```

> [!NOTE]
> To find out which are the environment variables, you should consult the owner
3. Rename .env.template to .env and fill the variables

## Running the app
1. Select the device
```bash
ctrl + shift + p & type Flutter: Select Device
```

2. Run the app
```bash
f5
```

## Build the app

1. Configure the Icon
```bash
dart run flutter_launcher_icons
```

2. Build the app for Android (APK)
```bash
flutter build apk
```

3. Build the app for Android (Bundle, in case you want to publish the app in the Play Store)
```bash
flutter build appbundle
```

### Optional commands
1. Install the app in the device (Android)
```bash
flutter install
```

2. To change the app package name, you can use the following command:
```bash
dart run change_app_package_name:main com.deltateam.gymnastic_center
```

## Testing
1. Run the tests
```bash
flutter test
```

## References

This project was made possible in large part thanks to Fernando Herrera, so on behalf of Delta Team we want to thank him. You can find his courses on [Udemy](https://www.udemy.com/course/flutter-cero-a-experto/) and [DevTalles](https://cursos.devtalles.com/courses/flutter-movil-cero-a-experto)

## Libraries
For the operation of the application several libraries were used, but the most important ones are:

- [firebase_messaging](https://pub.dev/packages/firebase_messaging). Used for push notifications.
- [flutter_bloc](https://pub.dev/packages/flutter_bloc). Used for state management.
- [video_player](https://pub.dev/packages/video_player). Used for video reproduction.
- [animate_do](https://pub.dev/packages/animate_do). Used for animations. (made by Fernando Herrera)
- [dio](https://pub.dev/packages/dio). Used for HTTP requests.
- [go_router](https://pub.dev/packages/go_router). Used for routing.

## Architecture
The architecture used was DDD based on [ResorCode](https://resocoder.com/2020/03/30/flutter-firebase-ddd-course-5-sign-in-form-logic/), which proposes four layers: 
- Application: It is the layer that contains the use cases. Making use of the bloc pattern.
- Domain: It is the layer that contains the business rules. It is the most important layer of the architecture.
- Infrastructure: It is the layer that contains the external elements of the application, such as the database, the network, etc.  
- Presentation: It is the layer that contains the UI of the application.


> [!NOTE]
> In this app we are using Firebase for the push notifications, so you need to configure the Firebase in the project. > In case you don't have the Firebase configured, you can follow the steps in the [Firebase](https://firebase.flutter.dev/docs/overview). This is important because the app uses push notifications for different functionalities and you need to configure your own Firebase project.

