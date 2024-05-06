part of 'themes_bloc.dart';

class ThemesState extends Equatable {
  final AppTheme appTheme;
  final bool isInitialized;

  const ThemesState(
      {this.appTheme = const AppTheme(), this.isInitialized = false});

  ThemesState copyWith({AppTheme? appTheme, bool? isInitialized}) =>
      ThemesState(
          appTheme: appTheme ?? this.appTheme,
          isInitialized: isInitialized ?? this.isInitialized);

  @override
  List<Object> get props => [appTheme, isInitialized];
}
