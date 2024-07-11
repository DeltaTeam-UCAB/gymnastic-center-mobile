import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

void main() {
  blocTest(
    'Should emit ThemesState with appTheme isDarkMode true when changeTheme is called',
    build: () => ThemesBloc(),
    act: (bloc) => bloc.changeTheme(),
    expect: () => [
      isA<ThemesState>()
          .having((state) => state.appTheme.isDarkMode, 'isDarkMode', true)
    ],
  );
}
