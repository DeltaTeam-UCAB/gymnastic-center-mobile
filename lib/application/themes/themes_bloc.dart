import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/presentation/core/theme/theme.dart';

part 'themes_event.dart';
part 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  ThemesBloc() : super(const ThemesState()) {
    on<ToggleDarkmode>(_toggleDarkmode);
    on<InitThemeSystem>(_initThemeSystem);
  }

  void _toggleDarkmode(ToggleDarkmode event, Emitter<ThemesState> emit) {
    final apptheme = state.appTheme;
    emit(state.copyWith(
        appTheme: apptheme.copyWith(isDarkMode: !apptheme.isDarkMode)));
  }

  void _initThemeSystem(InitThemeSystem event, Emitter<ThemesState> emit) {
    final apptheme = state.appTheme;
    emit(state.copyWith(
        appTheme: apptheme.copyWith(isDarkMode: event.value),
        isInitialized: true));
  }

  void changeTheme() {
    add(ToggleDarkmode());
  }

  void setInitTheme(bool value) {
    add(InitThemeSystem(value: value));
  }

  bool get isDarkMode => state.appTheme.isDarkMode;
}
