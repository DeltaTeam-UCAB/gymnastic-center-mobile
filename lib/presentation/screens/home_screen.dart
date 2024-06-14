import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/presentation/screens/notifications/notifications_screen.dart';
import 'package:gymnastic_center/presentation/screens/courses/courses_screen.dart';
import 'package:gymnastic_center/presentation/screens/tabs/settings_screen.dart';
import 'package:gymnastic_center/presentation/screens/tabs/views/home_view.dart';
import 'package:gymnastic_center/presentation/widgets/shared/navigation_bar/custom_bottom_navigation.dart';
import 'package:gymnastic_center/presentation/widgets/shared/side_menu.dart';

class HomeScreen extends StatelessWidget {
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final routes = <Widget>[
      FadeIn(child: const HomeView()),
      FadeIn(child: const AllCoursesScreen()),
      FadeIn(child: const SettingsScreen()),
      FadeIn(child: NotificationsScreen()),
    ];

    context.read<ClientsBloc>().getClientData();

    return Scaffold(
      key: scaffoldKey,
      body: IndexedStack(
        index: pageIndex,
        children: routes,
      ),
      drawer: pageIndex != 2 ? SideMenu(scaffoldKey: scaffoldKey) : null,
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }
}
