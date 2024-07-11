import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';

void main() {
  blocTest(
    'Should emit ThemesState with isInitialized true when setInitTheme is called',
    build: () => ThemesBloc(),
    act: (bloc) => bloc.setInitTheme(true),
    expect: () => [
      isA<ThemesState>()
          .having((state) => state.isInitialized, 'isInitialized', true)
          .having((state) => state.appTheme.isDarkMode, 'isDarkMode', true)
    ],
  );
}
