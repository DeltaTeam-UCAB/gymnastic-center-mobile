part of 'themes_bloc.dart';

abstract class ThemesEvent {
  const ThemesEvent();
}

class ToggleDarkmode extends ThemesEvent {}

class InitThemeSystem extends ThemesEvent {
  final bool value;
  InitThemeSystem({this.value = false});

  bool getValue() {
    return value;
  }
}
