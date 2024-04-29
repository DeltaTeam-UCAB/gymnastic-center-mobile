import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/presentation/core/router/app_router.dart';
import 'package:gymnastic_center/presentation/core/theme/theme.dart';

class GymnasticCenterApp extends StatelessWidget {
  const GymnasticCenterApp({super.key});

  @override
  Widget build(BuildContext context) {

    final AppTheme appTheme = context.watch<ThemesBloc>().state.appTheme;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: RoutesManager.appRouter,
      theme: appTheme.getTheme(),
    );
  }
}