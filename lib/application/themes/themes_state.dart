part of 'themes_bloc.dart';

class ThemesState extends Equatable {
  final AppTheme appTheme;

  const ThemesState({this.appTheme = const AppTheme()});

  ThemesState copyWith({AppTheme? appTheme}) => ThemesState(
        appTheme: appTheme ?? this.appTheme,
      );

  

  @override
  List<Object> get props => [appTheme];
}
