import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/presentation/core/theme/theme.dart';

part 'themes_event.dart';
part 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  ThemesBloc() : super(const ThemesState()) {
    on<ToggleDarkmode>(_toggleDarkmode);
  }

  void _toggleDarkmode(ToggleDarkmode event, Emitter<ThemesState> emit){
    final apptheme = state.appTheme;
    emit(state.copyWith(appTheme: apptheme.copyWith(isDarkMode: !apptheme.isDarkMode)));
  }

  void changeTheme(){
    add(ToggleDarkmode());
  }

  bool get isDarkMode => state.appTheme.isDarkMode;
}
