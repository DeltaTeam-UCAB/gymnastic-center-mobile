import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/presentation/core/router/app_router.dart';
import 'package:gymnastic_center/presentation/core/theme/theme.dart';

class GymnasticCenterApp extends StatelessWidget {
  const GymnasticCenterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalStorageService localStorage = LocalStorageService();
    final AppTheme appTheme = context.watch<ThemesBloc>().state.appTheme;
    final bool isThemeInit = context.watch<ThemesBloc>().state.isInitialized;
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    if (!isThemeInit) {
      localStorage.getValue<bool>('theme').then((value) {
        if (value == null) {
          localStorage.setKeyValue('theme', isDarkMode);
          context.read<ThemesBloc>().setInitTheme(isDarkMode);
        } else {
          context.read<ThemesBloc>().setInitTheme(value);
        }
      });
    } else {
      localStorage.setKeyValue('theme', appTheme.isDarkMode);
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: RoutesManager.appRouter,
      theme: appTheme.getTheme(),
    );
  }
}
