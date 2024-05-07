import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/notifications/bloc/notifications_bloc.dart';


class NotificationStatuScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final bool isNotificationsEnabled = context.watch<NotificationsBloc>().state.status;


    if (isNotificationsEnabled){
      return _notificationsActive(colors, context);
    }
    else{
      return _notificationsInactive(colors, context);
    }

  }

  Scaffold _notificationsActive(ColorScheme colors, BuildContext context) {
    return Scaffold(
      appBar: const _CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon( Icons.check_circle_outline , size: 250, color: colors.primary),
            Text('Notifications Enabled', style: TextStyle( fontSize: 20, color: colors.secondary)),
            Text('Let`s explore more context around you', style: TextStyle( fontSize: 15, color: colors.secondary )),

            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: FilledButton(
                onPressed: () => context.go(('/home/0')), 
                child: const Text('Back to Feed', style: TextStyle( fontSize: 20 )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Scaffold _notificationsInactive(ColorScheme colors, BuildContext context) {
    return Scaffold(
      appBar: const _CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon( Icons.notifications_off_outlined , size: 250, color: colors.primary ),
            Text('Notifications Disable', style: TextStyle( fontSize: 20, color: colors.secondary)),
            Text('Click the button to allow them', style: TextStyle( fontSize: 15, color: colors.secondary )),

            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: FilledButton(
                onPressed: () => context.read<NotificationsBloc>().requestPermission(),
                child: const Text('Allow Notifications', style: TextStyle( fontSize: 20 )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        children: [
          Text('Settings'),
          Spacer(),         
          SizedBox(width: 10)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}