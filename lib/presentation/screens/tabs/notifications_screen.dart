import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/infrastructure/models/push_message_model.dart';
import 'package:gymnastic_center/presentation/screens/tabs/widgets/notifications_listview.dart';

class NotificationsScreen extends StatelessWidget {

  NotificationsScreen({super.key});

  final List<PushMessageModel> myNotifications = [];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;


    if (myNotifications.isEmpty){
      return _emptyNotificationsView(colors, context);
    }

    return Scaffold(
      appBar: const _CustomAppBar(),
      body: NotificationsListView(notifications: myNotifications),
    );
  }

  Scaffold _emptyNotificationsView(ColorScheme colors, BuildContext context) {
    return Scaffold(
      appBar: const _CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon( Icons.notification_important_outlined , size: 200, color: colors.secondary ),
            Text('Can`t find notifications', style: TextStyle( fontSize: 20, color: colors.secondary)),
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
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        children: [
          Text('Notifications'),
          Spacer(),
          Text('0 Inbox', style: TextStyle(fontSize: 15),),
          Icon(Icons.delete_outline_rounded),
          SizedBox(width: 10)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}