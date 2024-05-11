# Gymnastic Center

Gymnastic Center is an Android app developed in Flutter that promotes physical and mental wellness through guided meditation and yoga courses.

## Getting Started

## Installation
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

## Optional commands
Install the app in the device (Android)
```bash
flutter install
```

To change the app package name, you can use the following command:
```bash
dart run change_app_package_name:main com.deltateam.gymnastic_center
```

> [!NOTE]
> In this app we are using Firebase for the push notifications, so you need to configure the Firebase in the project. > In case you don't have the Firebase configured, you can follow the steps in the [Firebase](https://firebase.flutter.dev/docs/overview).

