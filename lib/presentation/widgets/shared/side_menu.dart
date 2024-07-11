import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/presentation/core/menu/menu_items.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = -1;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
      backgroundColor: const Color.fromARGB(255, 109, 71, 219),
      tilePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        final menuitem = appMenuItems[value];
        context.push(menuitem.route);
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        const SizedBox(height: 20),
        Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 0 : 20, 16, 10),
            child: const Text('Gymnastic Center',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold))),
        ...appMenuItems.map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon, color: Colors.white),
              label:
                  Text(item.title, style: const TextStyle(color: Colors.white)),
            )),
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: TextButton.icon(
            onPressed: () {
              LocalStorageService().removeKey('token').then((_) {
                context.go('/start');
              });
            },
            icon: const Icon(Icons.logout_rounded, color: Colors.white,),
            label: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
